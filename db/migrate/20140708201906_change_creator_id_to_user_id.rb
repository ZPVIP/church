class ChangeCreatorIdToUserId < ActiveRecord::Migration
  def change
    rename_column :contacts, :creator_id, :user_id
  end
end
