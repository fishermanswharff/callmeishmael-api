require 'aws-sdk'

module AwsInterface
  Aws.config[:credentials] = Aws::Credentials.new('AKIAIPOX2WMWVUFJBMDQ', 'tLocOzzwd/3xE1w92wN/BI/Pc244cE/VCFSMVPWA')
  Aws.config[:region] = 'us-west-2'
  s3 = Aws::S3::Resource.new
  bucket = s3.bucket('callmeishmael-logs')

  bucket.objects.each do |objectsummary|
    # access to the objectsummary
    resp = objectsummary.get
    # save the resp.body.string to the db as a phonelog
    # p resp.body.string
  end
end