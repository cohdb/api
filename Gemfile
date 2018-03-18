source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'aws-sdk' # file storage
gem 'devise' # authentication
gem 'fast_jsonapi' # JSON serialization
gem 'omniauth' # OAuth
gem 'omniauth-steam' # Steam authentication
gem 'rails', '~> 5.0.6'
gem 'paperclip' # file attachments
gem 'pg', '~> 0.18' # postgres
gem 'puma', '~> 3.0' # web server
gem 'pundit' # authorization
gem 'rack-cors' # CORS handling
gem 'redis' # memcache
gem 'redis-rails'
gem 'rollbar' # error logging
gem 'steam-api' # Steam API

group :development, :test do
  gem 'awesome_print' # pretty printing
  gem 'byebug', platform: :mri # debugging
  gem 'dotenv-rails' # environment variable loading
  gem 'rspec-rails', '~> 3.7' # testing
end

group :development do
  gem 'better_errors' # better in-browser error UI
  gem 'binding_of_caller' # irb in better_errors
  gem 'bullet' # N+1 queries
  gem 'listen', '~> 3.0.5'
  gem 'redis-rails-instrumentation' # redis logging
  gem 'rubocop' # linting
  gem 'seedbank' # db seeding
end
