require "test_helper"

class Workspaces::Projects::Surveys::ResultsControllerTest < ActionDispatch::IntegrationTest
  test "GET #new should be successful" do
    get new_workspace_project_survey_result_path(workspaces(:johns_space), projects(:johns_project), surveys(:johns_project), as: users(:john))

    assert_response :success
  end

  test "POST #create should add new result entry and redirect" do
    workspace = workspaces(:johns_space)
    project = projects(:johns_project)
    survey = surveys(:johns_project)

    assert_difference "Result.count", 1 do
      post workspace_project_survey_results_path(
        workspace,
        project,
        survey,
        as: users(:john),
        params: {
          results: {
            market_segment_answers: {
              "first segment": "2"
            },
            market_segment_open_answer: "test answer to market segment open question"
          }
        }
      )
    end

    result = survey.results.last
    assert_equal result.market_segment_answers, { "first segment" => "2" }
    assert_equal result.market_segment_open_answer, "test answer to market segment open question"
    assert_response :redirect
  end

  test "PATCH #update should be successful and redirect" do
    workspace = workspaces(:johns_space)
    project = projects(:johns_project)
    survey = surveys(:johns_project)
    result = results(:johns_project_first_entry)

    assert_no_difference "Result.count" do
      patch workspace_project_survey_result_path(
        workspace,
        project,
        survey,
        result,
        as: users(:john),
        params: {
          results: {
            market_segment_answers: {
              "first segment": "2"
            },
            market_segment_open_answer: "test answer to market segment open question"
          }
        }
      )
    end

    assert_equal result.reload.market_segment_answers, { "first segment" => "2" }
    assert_equal result.reload.market_segment_open_answer, "test answer to market segment open question"
    assert_response :redirect
  end
end
