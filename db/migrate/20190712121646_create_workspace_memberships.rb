class CreateWorkspaceMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :workspace_memberships do |t|
      t.references :workspace, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
