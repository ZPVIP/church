class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end
    add_index :services, :parent_id
    add_index :services, :lft
    add_index :services, :rgt
    add_index :services, :depth
  end
end
