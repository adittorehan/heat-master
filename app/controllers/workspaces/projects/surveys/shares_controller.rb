class Workspaces::Projects::Surveys::SharesController < ApplicationController
  layout "editor"

  def show
    @project = current_project
    @survey = @project.survey
  end
end
