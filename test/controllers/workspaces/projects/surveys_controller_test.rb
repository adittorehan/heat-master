require "test_helper"

class Workspaces::Projects::SurveysControllerTest < ActionDispatch::IntegrationTest

  test "GET #new should be successful" do
    get new_workspace_project_survey_path(workspaces(:johns_space), projects(:johns_project), as: users(:john))

    assert_response :redirect
  end

  test "GET #edit should be successful" do
    get edit_workspace_project_survey_path(workspaces(:johns_space), projects(:johns_project), surveys(:johns_project), as: users(:john))

    assert_response :success
  end
end
