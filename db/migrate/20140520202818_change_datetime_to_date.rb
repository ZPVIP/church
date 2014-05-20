class ChangeDatetimeToDate < ActiveRecord::Migration
  def change
    change_column :contacts, :decision, :date
    change_column :contacts, :baptism, :date
  end
end
