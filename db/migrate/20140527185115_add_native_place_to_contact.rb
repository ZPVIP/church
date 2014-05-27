class AddNativePlaceToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :native_place, :string
  end
end
