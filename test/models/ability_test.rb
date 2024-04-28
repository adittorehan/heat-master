require "test_helper"

class AbilityTest < ActiveSupport::TestCase
  attr_reader :user

  setup do
    @user = users(:john)
  end

  test "can delete workspace only for workspace creators" do
    created_workspace = workspaces(:johns_space)
    others_workspace = workspaces(:marks_space)

    assert Ability.new(user).can?(:destroy, created_workspace)
    assert Ability.new(user).cannot?(:destroy, others_workspace)
  end

  test "can manage_surveys only for workspace members" do
    johns_project = projects(:johns_project)
    others_project = projects(:janes_project)

    assert Ability.new(user).can?(:manage_surveys, johns_project)
    assert Ability.new(user).cannot?(:manage_surveys, others_project)
  end
end
