require "#{Rails.root.join('lib', 'modules', 'aws_interface.rb')}"
include AwsInterface

namespace :phonelogs do

  desc "display the current environment of rake"
  task :current_environment do
    puts "You are running rake task in #{Rails.env} environment"
  end


  desc "Gets log files from AWS and populates the database with the contents of the files"
  task get: :environment do
    aws = AwsInterface::LogGetter.new
    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO
    Rails.logger = logger
    aws.init
  end

  desc "TODO"
  task post: :environment do
  end

end
