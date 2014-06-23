class RemoveColumnFromCalendar < ActiveRecord::Migration
  def change
    remove_column :calendars, :start
    remove_column :calendars, :end
  end
end
