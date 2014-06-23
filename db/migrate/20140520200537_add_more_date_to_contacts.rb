class AddMoreDateToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :decision, :datetime
    add_column :contacts, :decision_with, :string
    add_column :contacts, :baptism, :datetime
    add_column :contacts, :wechat, :string
  end
end
