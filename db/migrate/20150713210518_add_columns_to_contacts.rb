class AddColumnsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :unknown_year, :boolean
    add_column :contacts, :unknown_birthday, :boolean
    add_index :contacts, :unknown_year
    add_index :contacts, :unknown_birthday
  end
end
