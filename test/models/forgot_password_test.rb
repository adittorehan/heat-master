require 'test_helper'

class ForgotPasswordTest < ActiveSupport::TestCase
  should validate_presence_of :email
end
