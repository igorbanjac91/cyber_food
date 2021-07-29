source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem "devise", "~> 4.8"
gem "image_processing", ">= 1.2"
gem 'font-awesome-sass'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'capybara'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do 
  gem 'webdrivers', require: false
  gem 'selenium-webdriver'
  gem 'geckodriver-helper'
  gem 'rexml'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  gem 'boring_generators'
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  # gem 'spring-watcher-listen'
  # gem 'guard-livereload', require: false
  # gem 'rack-livereload'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

