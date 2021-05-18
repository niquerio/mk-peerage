source 'https://rubygems.org'
ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3'
gem 'pg', '~> 0.21.0' #set for heroku
#gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem "bootsnap", ">= 1.4.4", require: false

# Use Capistrano for deployment

gem 'devise', '~> 4.7.0'
gem 'aws-sdk-s3'
gem 'image_processing'
gem 'mini_magick'
gem "bootstrap_form",
    git: "https://github.com/bootstrap-ruby/bootstrap_form.git",
    branch: "master"
gem 'redcarpet'
gem 'cancancan'
gem 'ancestry'
gem 'validates_email_format_of'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'webpacker', '~> 4.x'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'sqlite3'
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem "rspec_junit_formatter"
  gem 'selenium-webdriver'
  gem 'pry'
  gem 'pry-byebug'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  #gem 'guard-rspec', require: false
  gem 'capistrano-rails'
  gem 'capistrano-nvm', require: false
  gem 'capistrano-rbenv'
  gem 'listen'
end

group :test do
  gem "shoulda-matchers"
  gem 'database_cleaner'
#  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'timecop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
