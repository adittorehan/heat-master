ENV['RAILS_ENV'] ||= 'test'
ENV['APP_HOST'] ||= 'localhost'

require_relative '../config/environment'
require 'rails/test_help'
require 'sidekiq/testing'
require "capybara/rails"

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end

class ActiveSupport::TestCase
  fixtures :all

  Sidekiq::Testing.inline!
end
