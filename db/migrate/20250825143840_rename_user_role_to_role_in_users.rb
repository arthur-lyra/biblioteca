class RenameUserRoleToRoleInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :user_role, :role
  end
end