class AddSpouseToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :spouse, :string
  end
end
