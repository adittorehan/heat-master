class ApplicationController < ActionController::Base
  include Clearance::Controller
  helper_method :current_workspace
  helper_method :current_project

  before_action :require_login
  before_action :ensure_user_has_a_workspace
  before_action :ensure_user_is_active

  private

  def current_workspace
    return @current_workspace if params[:workspace_id].nil?

    @current_workspace = Workspace.find(params[:workspace_id])
    authorize! :read, @current_workspace

    @current_workspace
  end

  def current_project
    Project.find(params[:project_id])
  end

  def ensure_user_has_a_workspace
    return if current_user.workspaces.any?

    redirect_to new_workspace_path
  end

  def ensure_user_is_active
    return if current_user.active?
    return unless ENV["NON_ACTIVE_USERS_REDIRECT_URL"].present?

    redirect_to ENV["NON_ACTIVE_USERS_REDIRECT_URL"]
  end
end
