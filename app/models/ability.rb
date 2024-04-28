class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      workspace_ids = user.workspace_memberships.pluck(:workspace_id)
      created_workspace_ids = user.workspace_memberships.creator(user).pluck(:workspace_id)

      can %i[read create update], Workspace, id: workspace_ids
      can :manage, Workspace, id: created_workspace_ids

      can :manage, WorkspaceMember, workspace_id: workspace_ids
      can :manage, WorkspaceMember, user_id: user.id
      can :manage_surveys, Project, workspace_id: workspace_ids
    end
  end
end
