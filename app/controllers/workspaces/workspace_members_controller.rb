class Workspaces::WorkspaceMembersController < ApplicationController
  def index
    @workspace_members = current_workspace.workspace_members.includes(:user)
    @workspace_member = WorkspaceMember.new(workspace: current_workspace)
    @active_tab = "team_members"
  end

  def new
    @workspace_member = WorkspaceMember.new(workspace: current_workspace)
    authorize! :create, @workspace_member
  end

  def create
    @workspace_member = WorkspaceMember.new(workspace_member_params)
    @workspace_member.user = User.find_by(email: workspace_member_params[:email])
    @workspace_member.workspace = current_workspace
    @workspace_member.inviter = current_user

    authorize! :create, @workspace_member

    if @workspace_member.save
      flash[:success] = "Member was successfully added."
      NotificationMailer.user_added_to_workspace(
        @workspace_member.user,
        @workspace_member.inviter,
        @workspace_member.workspace
      ).deliver_later

      redirect_to workspace_workspace_members_path(current_workspace)
    else
      render :new
    end
  end

  def destroy
    workspace_member = WorkspaceMember.find(params[:id])
    return if current_workspace.users.count < 2 || workspace_member.creator?

    authorize! :destroy, workspace_member

    if current_user == workspace_member.user
      redirect_to root_path if workspace_member.destroy
    else
      flash[:success] = "Member was successfully removed." if workspace_member.destroy
      NotificationMailer.
        user_removed_from_workspace(workspace_member.user, workspace_member.workspace).
        deliver_later

      redirect_to workspace_workspace_members_path(current_workspace)
    end
  end

  private

  def workspace_member_params
    params.require(:workspace_member).permit(:email)
  end
end
