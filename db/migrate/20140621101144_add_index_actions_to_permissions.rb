class AddIndexActionsToPermissions < ActiveRecord::Migration
  def change
    add_index :permissions, :action
  end
end
