class AddAdminToWorkspaceMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :workspace_members, :creator, :boolean, default: false

    workspaces_with_admins = []
    WorkspaceMember.find_each do |record|
      next if record.workspace_id.in? workspaces_with_admins

      record.update_attribute(:creator, true)
      workspaces_with_admins << record.workspace_id
    end
  end
end
