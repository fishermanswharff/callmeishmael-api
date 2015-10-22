require "#{Rails.root.join('lib', 'modules', 'aws_interface.rb')}"
include AwsInterface
require 'pry'

namespace :stories do

  desc 'send md5 files to aws'
  task :md5, [:type] => :environment do |t,args|
    Story.find_each do |story|
      filename = story.url.scan(/([\w\d\-\.\s]+)(?:\.ogg)/).flatten.join
      md5 = Digest::MD5.new
      hash = md5.update filename
      aws = AwsInterface::Md5Putter.new(hash, filename)
      if aws.response.exists?
        story.update!(md5_url: aws.response.public_url)
      end
    end
  end

  desc 'display the current environment of rake'
  task :current_environment do
    puts "You are running rake task in #{Rails.env} environment"
  end
end