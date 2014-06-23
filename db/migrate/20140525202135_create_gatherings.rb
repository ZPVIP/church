class CreateGatherings < ActiveRecord::Migration
  def change
    create_table :gatherings do |t|
      t.string :gathering
      t.string :description

      t.timestamps
    end
  end
end
