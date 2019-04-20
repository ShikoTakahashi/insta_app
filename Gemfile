source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'
gem 'rails', '~> 5.2.2'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'carrierwave'
gem 'mini_magick'
gem 'rmagick'
gem 'bcrypt'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'bootstrap-sass'
gem 'duktape'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'omniauth'
gem 'omniauth-facebook'

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'rubocop-airbnb'
  gem 'factory_bot_rails'
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'rails-controller-testing'
end

group :production do
  gem 'pg'
  gem 'fog'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
