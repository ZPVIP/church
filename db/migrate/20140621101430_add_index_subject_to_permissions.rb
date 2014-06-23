class AddIndexSubjectToPermissions < ActiveRecord::Migration
  def change
    remove_index :permissions, :action
  end
end
