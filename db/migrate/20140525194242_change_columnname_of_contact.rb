class ChangeColumnnameOfContact < ActiveRecord::Migration
  def change
    rename_column :contacts, :gathering, :gatherings_mask
  end
end
