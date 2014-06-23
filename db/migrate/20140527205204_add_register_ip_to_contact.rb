class AddRegisterIpToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :register_ip, :string
  end
end
