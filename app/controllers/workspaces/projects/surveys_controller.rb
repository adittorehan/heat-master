class Workspaces::Projects::SurveysController < ApplicationController # rubocop:disable Metrics/ClassLength
  layout "editor"

  def new
    @project = Project.find(params[:project_id])
    @survey = @project.build_survey(name: @project.name)
    build_survey_defaults

    authorize! :manage_surveys, @project

    render :new unless @survey.save

    Shortener::ShortenedUrl.generate(
      new_workspace_project_survey_result_url(@project.workspace, @project, @survey),
      category: "new survey"
    )
    redirect_to edit_workspace_project_survey_path(@project.workspace, @project, @survey)
  end

  def update
    @survey = Survey.find(params[:id])
    @survey.introduction.image.attach(params[:image])
  end

  def edit
    @project = Project.find(params[:project_id])
    @survey = Survey.find(params[:id])
    @survey_introduction_image = nil
    @survey_introduction_image = url_for(@survey.introduction.image) if @survey.introduction.image.attached?

    authorize! :manage_surveys, @project
  end

  private

  def build_survey_defaults
    @survey.build_introduction(introduction_default)
    @survey.build_market_segment(market_segment_default)
    @survey.build_problem_statement(problem_statement_default)
    @survey.build_solution_statement(solution_statement_default)
    @survey.build_feedback(feedback_default)
    @survey.build_ending(ending_default)
  end

  def introduction_default
    {
      headline: "Market research",
      subheadline: <<~HEREDOC.squish
        We are working on X to help Y do Z. We would like to ask you a couple of questions to help
        us evaluate the market. We estimate the survey will take no longer than 10 minutes of your
        time. Thanks!
      HEREDOC
    }
  end

  def market_segment_default
    {
      headline: "How much do you identify with these statements?",
      subheadline: <<~HEREDOC.squish,
        For each of the statements below, please rate how well the statement resonates with you.
        1 means the statement does not describe you at all,
        5 means the statement describes you very well.
      HEREDOC
      open_ended_question: true,
      min_scale: 1,
      max_scale: 5,
      lowest_value_label: "don’t identify",
      highest_value_label: "strongly identify",
      segment_questions: { "0":
                             %w[
                               Parents that got their first child in the last year live in a suburb
                               and are used to online buying.
                             ].join(" ") }
    }
  end

  def problem_statement_default
    {
      headline: "Which of the following problem/need statements resonate with you?",
      subheadline: <<~HEREDOC.squish,
        For each of the statements below, please rate how significant they are to you.
        1 means the statement is not relevant at all,
        5 means the statement is very relevant.
      HEREDOC
      open_ended_question: true,
      min_scale: 1,
      max_scale: 5,
      lowest_value_label: "don’t identify",
      highest_value_label: "strongly identify",
      problem_segments: { "0": "I’m struggling with buying diapers because they are expensive." }
    }
  end

  def solution_statement_default
    {
      headline: "Which of the following solution statements appeal to you?",
      subheadline: <<~HEREDOC.squish,
        Thinking about your current situation, please rate how well you feel
        the following solution ideas will address your particular needs.
        1 means the statement does not resonate with you at all, 5 means
        the statement resonates with you very well.
      HEREDOC
      open_ended_question: true,
      min_scale: 1,
      max_scale: 5,
      lowest_value_label: "don’t identify",
      highest_value_label: "strongly identify",
      solution_segments: { "0":
                             %w[
                               Diaper subscription that asks if new diapers are needed (via sms or app)
                               and ships it only when needed.
                             ].join(" ") }
    }
  end

  def feedback_default
    {
      headline: "Final Details",
      subheadline: "Thank you for filling out the survey, but before you go...",
      ask_for_testing: true,
      ask_for_testing_label: <<~HEREDOC.squish,
        Are you willing to help us further?
        Please select which ways you are willing to help us out:
      HEREDOC
      ask_for_testing_options: [
        "Provide feedback on prototypes",
        "Answer some questions in a live interview",
        "Participate in user testing"
      ].join("\n"),
      ask_for_email: true,
      ask_for_email_label: <<~HEREDOC,
        Please leave your e-mail address if you want to be kept updated (we won't share it with third parties)
      HEREDOC
      open_ended_question: true
    }
  end

  def ending_default
    {
      headline: "Thank you for taking the survey!",
      subheadline: "To create your own survey, please visit www.heatcheck.co"
    }
  end
end
