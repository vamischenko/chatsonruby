source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.3'

gem 'rails', '~> 6.1.7'
# Minitest 6 тянет нативный prism; для совместимости со стеком Rails 6.1 оставляем 5.x
gem 'minitest', '~> 5.25'
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 6.4'
gem 'sass-rails', '~> 6.0'
gem 'webpacker', '~> 5.4'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.13'
gem 'bootsnap', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 6.1'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'faker', '~> 3.5'
end

group :development do
  gem 'web-console', '>= 4.2'
  gem 'listen', '~> 3.9'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1'
end

group :test do
  gem 'capybara', '~> 3.40'
  gem 'selenium-webdriver', '~> 4.27'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'devise', '~> 4.9'
gem 'pry-rails'
gem 'image_processing', '~> 1.13'
