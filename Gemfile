source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'aws-sdk' # file storage
gem 'devise' # authentication
gem 'doorkeeper' # token auth
gem 'dotenv-rails' # environment variable loading
gem 'fast_jsonapi' # JSON serialization
gem 'ffi' # foreign function interface for Rust parser
gem 'omniauth' # OAuth
gem 'omniauth-steam', git: 'https://github.com/cohdb/omniauth-steam.git' # Steam authentication
gem 'rails', '~> 5.0.6'
gem 'paperclip' # file attachments
gem 'pg', '~> 0.18' # postgres
gem 'puma', '~> 3.0' # web server
gem 'pundit', git: 'https://github.com/varvet/pundit.git' # authorization
gem 'rack-cors' # CORS handling
gem 'redis' # memcache
gem 'redis-rails'
gem 'rollbar' # error logging
gem 'steam-api' # Steam API
gem 'sucker_punch', '~> 2.0' # async workers

group :development, :test do
  gem 'awesome_print' # pretty printing
  gem 'byebug', platform: :mri # debugging
  gem 'rspec-rails', '~> 3.7' # testing
end

group :development do
  gem 'better_errors' # better in-browser error UI
  gem 'binding_of_caller' # irb in better_errors
  gem 'bullet' # N+1 queries
  gem 'capistrano', '~> 3.6' # Deployment
  gem 'capistrano-bundler', '~> 1.2' # Bundle install on deploy
  gem 'capistrano-passenger' # Restart passenger on deploy
  gem 'capistrano-rails', '~> 1.3' # Migrate/compile assets on deploy
  gem 'capistrano-rbenv', '~> 2.0' # rbenv with deploy
  gem 'listen', '~> 3.0.5'
  gem 'redis-rails-instrumentation' # redis logging
  gem 'rubocop' # linting
  gem 'seedbank' # db seeding
end
