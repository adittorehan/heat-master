class Workspaces::Projects::Surveys::AnalyticsController < ApplicationController
  layout "editor"

  def show
    @project = current_project
    @survey = @project.survey
  end
end
