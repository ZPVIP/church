class AddBirthMonthToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :birth_month, :integer
    add_index :contacts, :birth_month
  end
end
