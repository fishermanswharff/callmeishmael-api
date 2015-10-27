source 'https://rubygems.org'
ruby '2.2.1'
gem 'rails', '4.2.1'
gem 'rails-api'
gem 'pg', '0.17.1'
gem 'newrelic_rpm'
gem 'rack-cors'
gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
gem 'nokogiri'
gem 'bcrypt'
gem 'rack-ssl-enforcer'
gem 'aws-sdk', '~> 2'
gem 'capistrano', '~> 3.1.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rbenv', github: 'capistrano/rbenv'

group :development, :test do
  gem 'spring'
  gem 'rubocop'
  gem 'bullet'
  gem 'lol_dba'
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'annotate'
end

group :development do
  gem 'guard'
  gem 'guard-rails'
end

group :test do
  gem 'capybara'
  gem 'rspec-rails', '~> 3.3.0'
  gem 'database_cleaner'
  gem 'webmock'
  gem 'codeclimate-test-reporter', require: nil
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
  gem 'rails_stdout_logging'
  gem 'rails_serve_static_assets'
end
