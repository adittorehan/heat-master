require "test_helper"

class WorkspaceMemberTest < ActiveSupport::TestCase
  should belong_to :workspace
  should belong_to :user

  should validate_uniqueness_of(:workspace).scoped_to(:user_id)
end
