require "test_helper"

class WorkspaceTest < ActiveSupport::TestCase
  should have_many :workspace_members
  should have_many :users
  should have_many :projects

  should validate_presence_of :name
end
