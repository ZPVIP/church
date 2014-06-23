class AddColumnToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :come, :datetime
    add_column :contacts, :go, :datetime
  end
end
