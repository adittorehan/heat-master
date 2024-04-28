class Workspaces::ProjectsController < ApplicationController
  def index
    @projects = current_workspace.projects
    @active_tab = "surveys"
  end

  def new
    @project = current_workspace.projects.new
  end

  def create
    @project = current_workspace.projects.new(project_params)

    if @project.save
      redirect_to new_workspace_project_survey_path(current_workspace, @project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to workspace_projects_path(@project.workspace)
    else
      render :edit
    end
  end

  def destroy
    project = Project.find(params[:id])

    redirect_to workspace_projects_path(project.workspace) if project.destroy
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
