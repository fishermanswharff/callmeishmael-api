require "#{Rails.root.join('lib', 'modules', 'aws_interface.rb')}"
include AwsInterface

namespace :phonelogs do

  desc "display the current environment of rake"
  task :current_environment do
    puts "You are running rake task in #{Rails.env} environment"
  end

  desc "Gets log files from AWS and populates the database with the contents of the files"
  task :get, [:type] => :environment do |t,args|
    aws = AwsInterface::LogGetter.new
    aws.init(args[:type])
  end
end

=begin

usage:

rake phonelogs:get['db']
gets the phonelogs from aws, parses them and saves them to the db,
associated with the phone by the key of the object (ie venue_1/phone_1/xxxxxxxxxx.txt)

=end
