require "#{Rails.root.join('lib', 'modules', 'aws_interface.rb')}"
include AwsInterface

namespace :stories do

  desc 'send md5 files to aws'
  task :md5, [:type] => :environment do |t,args|
    Story.find_each do |story|
      md5 = Digest::MD5.new
      filename = story.url.scan(/([\w\d\-\.\s]+)(?:\.ogg)/).flatten.join
      aws = AwsInterface::AudioGetter.new(ENV['S3_FILES_BUCKET_NAME'], filename + '.ogg')
      contents = aws.response.body.read
      hash = md5.hexdigest contents
      aws = AwsInterface::Md5Putter.new(hash,filename)
      story.update!(md5_url: aws.response.public_url) if aws.response.exists?
    end
  end

  desc 'display the current environment of rake'
  task :current_environment do
    puts "You are running rake task in #{Rails.env} environment"
  end
end