class NotificationMailer < ApplicationMailer
  def user_added_to_workspace(user, inviter, workspace)
    @user = user
    @inviter = inviter
    @workspace = workspace

    mail to: @user.email,
         subject: @inviter.full_name + " has invited you to a Heatcheck workspace"
  end

  def user_removed_from_workspace(user, workspace)
    @user = user
    @workspace = workspace

    mail to: @user.email,
         subject: "You are no longer part of the #{@workspace.name} Workspace on Heatcheck"
  end
end
