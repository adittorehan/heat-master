class Workspaces::Projects::Surveys::ResultsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :ensure_user_has_a_workspace
  skip_before_action :ensure_user_is_active
  skip_authorize_resource only: %i[new create edit update]

  layout "survey"

  def new
    @project = current_project
    @survey = @project.survey
    @result = Result.new
    @survey.results.build
    @step = @result.step
  end

  def create
    @project = current_project
    @survey = @project.survey
    @result = @survey.results.build(result_params)
    @step = @result.step
    @result.assign_attributes(step: @step + 1)

    if @result.save
      Shortener::ShortenedUrl.generate(
        edit_workspace_project_survey_result_path(@project.workspace, @project, @survey, @result),
        category: "continued survey"
      )
      redirect_to edit_workspace_project_survey_result_path(@project.workspace, @project,
                                                            @project.survey, @result)
    else
      render :new
    end
  end

  def edit
    @result = Result.find(params[:id])
    @survey = @result.survey
    @project = @survey.project
    @step = @result.step
  end

  def update
    @result = Result.find(params[:id])
    @survey = @result.survey
    @project = @survey.project
    @step = @result.step

    @result.assign_attributes(result_params)

    step_assignment

    if @result.save
      redirect_to next_step
    else
      render :edit
    end
  end

  private

  def step_assignment
    if params[:commit] == "Back"
      @result.assign_attributes(step: @step - 1)
    elsif @step == 4 && !@survey.feedback.active?
      @result.assign_attributes(step: @step + 2)
    else
      @result.assign_attributes(step: @step + 1)
    end
  end

  def result_params
    params.require(:results).permit(:market_segment_open_answer,
                                    :problem_statement_open_answer,
                                    :solution_statement_open_answer,
                                    :feedback_email,
                                    :feedback_open_answer,
                                    :step,
                                    market_segment_answers: {},
                                    problem_statement_answers: {},
                                    solution_statement_answers: {},
                                    feedback_answers: {})
  end

  def next_step
    case @result.step
    when 1..6
      edit_workspace_project_survey_result_path
    else
      workspace_projects_path(current_workspace)
    end
  end
end
