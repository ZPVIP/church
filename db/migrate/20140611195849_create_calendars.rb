class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.date :datum
      t.datetime :start
      t.datetime :end
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end
    add_index :calendars, :parent_id
    add_index :calendars, :lft
    add_index :calendars, :rgt
    add_index :calendars, :depth
  end
end
