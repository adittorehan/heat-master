class WorkspacesController < ApplicationController
  skip_before_action :ensure_user_has_a_workspace, only: %i[new create]
  skip_before_action :ensure_user_is_active, only: %i[new create]

  def index
    workspace = current_user.workspaces.first
    redirect_to workspace_projects_path(workspace)
  end

  def new
    @workspace = Workspace.new
  end

  def create
    @workspace = Workspace.new(workspace_params)
    @workspace.workspace_members.build(user: current_user, creator: true)

    if @workspace.save
      redirect_to workspace_projects_path(@workspace)
    else
      render :new
    end
  end

  def edit
    @workspace = Workspace.find(params[:id])
    @current_workspace = @workspace
  end

  def update
    @workspace = Workspace.find(params[:id])

    if @workspace.update(workspace_params)
      flash[:success] = "Workspace successfully updated."
      redirect_to edit_workspace_path(@workspace)
    else
      flash[:error] = "Could not save workspace."
      render :edit
    end
  end

  def destroy
    workspace = Workspace.find(params[:id])
    authorize! :destroy, workspace

    return if current_user.workspaces.count < 2

    redirect_to workspaces_path if workspace.destroy
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name)
  end
end
