class ChangeMeetUsToGatheringInContacts < ActiveRecord::Migration
  def change
    rename_column :contacts, :meet_us, :gathering
  end
end
