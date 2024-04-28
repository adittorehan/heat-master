class Workspaces::Projects::Surveys::DetailedAnalyticsController < ApplicationController
  layout "editor"

  def show
    @project = current_project
    @survey = @project.survey
  end
end
