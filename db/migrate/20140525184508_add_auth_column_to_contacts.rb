class AddAuthColumnToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :authenticated, :boolean
  end
end
