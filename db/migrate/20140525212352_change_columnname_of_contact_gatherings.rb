class ChangeColumnnameOfContactGatherings < ActiveRecord::Migration
  def change
    remove_column :contacts, :gatherings_mask
    rename_column :contact_gatherings, :gethering_id, :gathering_id
  end
end
