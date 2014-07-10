class RemoveColumnFromUserContacts < ActiveRecord::Migration
  def change
    remove_column :user_contacts, :id
    remove_column :user_contacts, :created_at
    remove_column :user_contacts, :updated_at
    add_index :user_contacts, [:user_id, :contact_id]
    add_index :user_contacts, [:contact_id, :user_id]
  end
end
