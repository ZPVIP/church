class RemoveGroupFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :group
  end
end
