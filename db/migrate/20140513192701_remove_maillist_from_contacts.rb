class RemoveMaillistFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :maillist
    change_column :contacts, :comment, :text
  end
end
