class RenameWorkspaceMembershipsToMembers < ActiveRecord::Migration[5.2]
  def change
    rename_table :workspace_memberships, :workspace_members
  end
end
