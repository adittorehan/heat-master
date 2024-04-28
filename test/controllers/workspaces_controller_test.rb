require "test_helper"

class WorkspacesControllerTest < ActionDispatch::IntegrationTest
  test "GET #new should be successful" do
    get new_workspace_path as: users(:john)
    assert_response :success
  end

  test "POST #create should add new workspace" do
    assert_difference "Workspace.count", 1 do
      post workspaces_url(as: users(:john), params: { workspace: { name: "New Workspace" } })
    end

    assert_equal Workspace.last.name, "New Workspace"
    assert_response :redirect
  end


  test "POST #create should add team member" do
    assert_difference "WorkspaceMember.count", 1 do
      assert_difference "Workspace.count", 1 do
        post workspaces_url(as: users(:john), params: { workspace: { name: "New Workspace" } })
      end
    end

    workspace = Workspace.last

    assert_includes workspace.users, users(:john)

    assert_response :redirect
  end

  test "POST #create with invalid data renders" do
    assert_no_difference "WorkspaceMember.count" do
      assert_no_difference "Workspace.count" do
        post workspaces_url(as: users(:john), params: { workspace: { name: "" } }), xhr: true
      end
    end

    assert_response :success
  end

  test "GET #index should find user's first workspace and redirect to its project overview" do
    workspace = workspaces(:marks_space)
    user = users(:john)

    get workspaces_path(workspace, as: user)

    assert_redirected_to workspace_projects_path(workspace)
  end

  test "GET #edit should be successful" do
    workspace = workspaces(:johns_space)

    get edit_workspace_path(workspace, as: users(:john))
    assert_response :success
  end

  test "PATCH update should be successful and redirect" do
    workspace = workspaces(:johns_space)
    user = users(:john)

    assert_not_equal workspace.name, "New Workspace name"

    patch workspace_path(
            workspace,
            as: user,
            workspace: { name: "New Workspace name" }
          )

    workspace.reload

    assert_equal workspace.name, "New Workspace name"

    assert_response :redirect
  end

  test "DELETE #destroy should be successful and redirect" do
    workspace = workspaces(:johns_space)
    user = users(:john)

    assert_not_equal 1, user.workspaces.count

    assert_difference "user.workspaces.count", -1 do
      delete workspace_path(
               workspace,
               as: user
             )
    end

    assert_response :redirect
  end

  test "DELETE #destroy should be failed if user has only one workspace" do
    workspace = workspaces(:janes_space)
    user = users(:jane)

    assert_equal 1, user.workspaces.count

    assert_no_difference "user.workspaces.count" do
      delete workspace_path(
               workspace,
               as: user
             )
    end

    assert_response :success
  end
end
