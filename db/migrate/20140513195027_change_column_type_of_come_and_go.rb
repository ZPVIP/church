class ChangeColumnTypeOfComeAndGo < ActiveRecord::Migration
  def change
    change_column :contacts, :come, :date
    change_column :contacts, :go, :date
  end
end
