# Load the Rails application.
require File.expand_path('../application', __FILE__)
ENV['RAILS_ENV'] ||= 'production'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  user_name:            ENV['GMAIL_USER_NAME'],
  password:             ENV['GMAIL_PASSWORD'],
  authentication:       :plain,
  enable_starttls_auto: true,
  openssl_verify_mode:  'none'
}