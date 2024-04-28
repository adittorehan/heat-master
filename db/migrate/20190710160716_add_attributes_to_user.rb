class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_name, :string, limit: 128
    add_column :users, :first_name, :string, limit: 128
    add_column :users, :admin, :boolean
  end
end
