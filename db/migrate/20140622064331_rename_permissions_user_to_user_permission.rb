class RenamePermissionsUserToUserPermission < ActiveRecord::Migration
  def change
    rename_table :permissions_users, :user_permissions
  end
end
