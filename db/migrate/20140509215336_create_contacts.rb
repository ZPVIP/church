class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :group
      t.string :name
      t.integer :gender
      t.string :telephone
      t.string :mobile
      t.string :email
      t.string :address
      t.date :birthday
      t.boolean :maillist
      t.string :comment

      t.timestamps
    end
  end
end
