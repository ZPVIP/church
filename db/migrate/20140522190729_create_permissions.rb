class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :action
      t.string :subject
      t.string :description

      t.timestamps
    end
  end
end
