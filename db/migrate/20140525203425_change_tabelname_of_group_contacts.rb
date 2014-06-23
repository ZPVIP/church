class ChangeTabelnameOfGroupContacts < ActiveRecord::Migration
  def change
    rename_table :group_contacts, :contact_groups
  end
end
