class AddBlockedToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :admin, :blocked
  end
end
