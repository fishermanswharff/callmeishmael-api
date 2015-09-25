require 'aws-sdk'

module AwsInterface

  class LogGetter

    def init(output = 'db')
      Aws.config[:credentials] = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
      Aws.config[:region] = 'us-west-2'
      s3 = Aws::S3::Resource.new
      client = Aws::S3::Client.new
      bucket = s3.bucket('callmeishmael-logs')
      bucket.objects.each do |objectsummary|
        venue_match = /venue_(\d)/.match(objectsummary.key).values_at(-1)[0]
        phone_match = /phone_(\d)/.match(objectsummary.key).values_at(-1)[0]
        resp = objectsummary.get
        log_content = resp.body.string
        if output == 'local'
          write_to_file(objectsummary.key, make_safe(log_content))
        else
          write_to_db(objectsummary.key, make_safe(log_content))
        end
      end
    end

    def make_safe(string)
      string.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    end

    def write_to_db(key, log_content)
      phone = Phonelog.create!(phone: Phone.find(/phone_(\d)/.match(key).values_at(-1)[0]), log_content: log_content)
      phone.save
    end

    def write_to_file(key, content)
      return if File.exist?(key)
      venue_path = /venue_\d\//.match(key).values_at(0)[0]
      phone_path = /phone_\d\//.match(key).values_at(0)[0]
      folder_structure = "#{venue_path}#{phone_path}"
      Dir.chdir("#{Rails.root.join('docs')}")
      if Dir.exist?(folder_structure)
        Dir.chdir(folder_structure)
      else
        Dir.mkdir(venue_path) unless File.directory?(folder_structure)
        Dir.chdir("#{Rails.root.join('docs', venue_path )}")
        Dir.mkdir(phone_path) unless File.directory?(folder_structure)
        Dir.chdir("#{Rails.root.join('docs', venue_path, phone_path )}")
      end
      output = File.open("#{key.gsub(/venue_\d\/phone_\d\//, '')}", "w")
      output.write content
      output.close
    end
  end
end

=begin
# Phonelog.create!(phone: Phone.find(phone_match), log_content: log_content)
resp:
 #<struct Aws::S3::Types::GetObjectOutput
 body=#<StringIO:0x007fca5ceb9dc0>,
 delete_marker=nil,
 accept_ranges="bytes",
 expiration=nil,
 restore=nil,
 last_modified=2015-05-28 16:16:41 +0000,
 content_length=3437,
 etag="\"621980dfddd10a53b5ff320328127ab8\"",
 missing_meta=nil,
 version_id=nil,
 cache_control=nil,
 content_disposition=nil,
 content_encoding=nil,
 content_language=nil,
 content_range=nil,
 content_type="",
 expires=nil,
 website_redirect_location=nil,
 server_side_encryption=nil,
 metadata={},
 sse_customer_algorithm=nil,
 sse_customer_key_md5=nil,
 ssekms_key_id=nil,
 storage_class=nil,
 request_charged=nil,
 replication_status=nil>


# objectsummary.key #=> "venue_1/phone_1/1432829800.473828554.txt"

ls objectsummary
Aws::Resources::Resource#methods: client  data  data_loaded?  exists?  identifiers  inspect  load  reload  wait_until
Aws::S3::ObjectSummary#methods:
  acl     bucket_name     copy_from  etag  initiate_multipart_upload  last_modified     object  put   storage_class  version            wait_until_not_exists
  bucket  content_length  delete     get   key                        multipart_upload  owner   size  upload_file    wait_until_exists
instance variables: @client  @data  @identifiers

=end
