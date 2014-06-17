class ChangNameToTitleInServices < ActiveRecord::Migration
  def change
    rename_column :services, :name, :title
  end
end
