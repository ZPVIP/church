class ChangeBlockedToBool < ActiveRecord::Migration
  def change
    change_column :users, :blocked, :boolean
  end
end
