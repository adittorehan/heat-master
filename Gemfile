source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.1"

gem "aws-sdk-s3", require: false
gem "bootsnap", ">= 1.1.0", require: false
gem "cancancan", "~> 2.0"
gem "clearance", "~> 1.17"
gem "coffee-rails", "~> 4.2"
gem "inline_svg", "~> 1.5"
gem "intercom-rails", "~> 0.4.1"
gem "pg", "~> 1.1"
gem "puma", "~> 3.12.6"
gem "rails", "~> 5.2.3"
gem "react-rails", "~> 2.6"
gem "sass-rails", "~> 5.0"
gem "sendgrid-ruby"
gem "shortener", "~> 0.8.0"
gem "sidekiq", "~> 5.2"
gem "sidekiq-cron", "~> 1.1"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "webpacker", "~> 4.0"

group :development, :test do
  gem "byebug", platforms: [:mri]
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
end

group :development do
  gem "brakeman", "~> 4.5"
  gem "dotenv-rails", "~> 2.7"
  gem "letter_opener"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", "~> 0.72.0"
  gem "scss_lint", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "bundle-audit", "~> 0.1.0"
  gem "chromedriver-helper"
  gem "minitest-matchers_vaccine", "~> 1.0"
  gem "shoulda", "~> 3.6"
  gem "shoulda-matchers", "~> 3.1"
end
