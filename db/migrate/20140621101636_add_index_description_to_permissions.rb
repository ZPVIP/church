class AddIndexDescriptionToPermissions < ActiveRecord::Migration
  def change
    add_index :permissions, :description
  end
end
