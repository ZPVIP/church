class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index :contacts, :name
    add_index :contacts, :birthday
    add_index :contacts, :created_at
    add_index :users, :name
  end
end
