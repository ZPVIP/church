class CreateContactGatherings < ActiveRecord::Migration
  def change
    create_table :contact_gatherings do |t|
      t.integer :contact_id
      t.integer :gethering_id
      t.timestamps
    end
  end
end
