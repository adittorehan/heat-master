require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of :password

  should have_many :workspace_memberships
  should have_many :workspaces
end
