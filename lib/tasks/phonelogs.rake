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


# namespace :tweets do
#   desc 'Send some tweets to a user'
#   task :send, [:username] => [:environment] do |t, args|
#     Tweet.send(args[:username])
#   end
# end