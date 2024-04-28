require "test_helper"

class Workspaces::WorkspaceMembersControllerTest < ActionDispatch::IntegrationTest
  test "GET index should be successful" do
    workspace = workspaces(:johns_space)
    get workspace_workspace_members_path(workspace, as: users(:john))

    assert_response :success
  end

  test "GET new should be successful" do
    workspace = workspaces(:johns_space)
    get new_workspace_workspace_member_path(workspace, as: users(:john)), xhr: true

    assert_response :success
  end

  test "POST create should redirect when user is added" do
    workspace = workspaces(:johns_space)
    john = users(:john)
    jane = users(:jane)

    assert_difference "workspace.users.count", 1 do
      assert_difference "jane.workspaces.count", 1 do
        post workspace_workspace_members_url(workspace, as: john, params: {
          workspace_member: {
            email: jane.email,
          }
        })
      end
    end

    assert_response :redirect
  end

  test "POST create should render when email doesn't exist" do
    workspace = workspaces(:johns_space)
    john = users(:john)

    assert_no_difference "workspace.users.count" do
      post workspace_workspace_members_url(workspace, as: john, params: {
        workspace_member: {
          email: "non-existing-user@example.com"
        }
      }), xhr: true
    end

    assert_response :success
  end

  test "POST create should render when email already exists in team" do
    workspace = workspaces(:johns_space)
    john = users(:john)

    assert_no_difference "workspace.users.count" do
      assert_no_difference "john.workspaces.count" do
        post workspace_workspace_members_url(workspace, as: john, params: {
          workspace_member: {
            email: john.email
          }
        }), xhr: true
      end
    end

    assert_response :success
  end

  test "POST create should be successful when user email contains capital letters" do
    workspace = workspaces(:johns_space)
    john = users(:john)
    jane = users(:jane)
    jane_capital_email = jane.email.upcase

    assert_difference "workspace.users.count", 1 do
      assert_difference "jane.workspaces.count", 1 do
        post workspace_workspace_members_path(workspace_id: workspace.id, as: john, params: {
          workspace_member: {
            email: jane_capital_email
          }
        }), xhr: true
      end
    end

    assert_response :success
  end

  test "DELETE #destroy should be successful and delete user from workspace" do
    workspace = workspaces(:johns_space)
    john = users(:john)
    marks_membership = workspace_members(:marks_membership)

    assert_difference "workspace.users.count", -1 do
      delete workspace_workspace_member_path(
               workspace,
               marks_membership,
               as: john
             )
    end

    assert_response :redirect
  end

  test "DELETE #destroy should be failed for the only user in the workspace" do
    workspace = workspaces(:janes_space)
    jane = users(:jane)
    janes_membership = workspace_members(:janes_membership)

    assert_equal 1, workspace.users.count

    assert_no_difference "workspace.users.count" do
      delete workspace_workspace_member_path(
               workspace,
               janes_membership,
               as: jane
             )
    end

    assert_response :success
  end

  test "DELETE #destroy should be failed for the creator members" do
    workspace = workspaces(:johns_space)
    mark = users(:mark)
    johns_membership = workspace_members(:johns_membership)

    assert_equal 2, workspace.users.count

    assert_no_difference "workspace.users.count" do
      delete workspace_workspace_member_path(
               workspace,
               johns_membership,
               as: mark
             )
    end

    assert_response :success
  end
end
