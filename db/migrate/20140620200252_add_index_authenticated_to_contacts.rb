class AddIndexAuthenticatedToContacts < ActiveRecord::Migration
  def change
    add_index :contacts, :authenticated
  end
end
