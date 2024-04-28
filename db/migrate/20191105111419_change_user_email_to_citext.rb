class ChangeUserEmailToCitext < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")

    change_column :users, :email, :citext
  end
end
