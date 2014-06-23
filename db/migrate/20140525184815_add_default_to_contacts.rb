class AddDefaultToContacts < ActiveRecord::Migration
  def change
    change_column :contacts, :authenticated, :boolean, default: false
  end
end
