require "test_helper"

class Workspaces::ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "GET #index should be successful" do
    get workspace_projects_path(workspaces(:johns_space), as: users(:john))

    assert_response :success
  end

  test "GET #new should be successful" do
    get new_workspace_project_path(workspaces(:johns_space), as: users(:john))

    assert_response :success
  end

  test "POST #create should add new project and redirect" do
    workspace = workspaces(:johns_space)

    assert_difference "Project.count", 1 do
      post workspace_projects_path(
             workspace,
             as: users(:john),
             params: {
               project: {
                 name: "Example Project",
               }
             }
           )
    end

    project = Project.last
    assert_equal project.name, "Example Project"

    assert_response :redirect
  end

  test "POST #create with invalid data should render" do
    workspace = workspaces(:johns_space)

    assert_no_difference "Project.count" do
      post workspace_projects_path(
             workspace,
             as: users(:john),
             params: {
               project: {
                 name: "",
               }
             }
           )
    end

    assert_response :success
  end

  test "GET #edit should be successful" do
    workspace = workspaces(:johns_space)
    project = projects(:johns_project)

    get edit_workspace_project_path(workspace, project, as: users(:john)), xhr: true
    assert_response :success
  end

  test "PATCH #update should be successful and update name of the Survey" do
    workspace = workspaces(:johns_space)
    project = projects(:johns_project)
    survey = project.survey

    assert_not_equal project.name, "New Project name"
    assert_not_equal survey.name, "New Project name"


    assert_no_difference "Project.count", 1 do
      patch workspace_project_path(
              workspace,
              project,
              as: users(:john),
              params: {
                project: {
                  name: "New Project name",
                }
              }
            )
    end

    assert_equal project.reload.name, "New Project name"
    assert_equal survey.reload.name, project.reload.name

    assert_response :redirect
  end

  test "DELETE #destroy should be successful and delete project" do
    workspace = workspaces(:johns_space)
    project = projects(:johns_project)

    assert_difference "Project.count", -1 do
      delete workspace_project_path(
               workspace,
               project,
               as: users(:john)
             )
    end

    assert_response :redirect
  end
end


