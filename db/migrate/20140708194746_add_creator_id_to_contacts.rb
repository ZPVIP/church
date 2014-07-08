class AddCreatorIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :creator_id, :integer
  end
end
