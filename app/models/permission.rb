class Permission < ActiveRecord::Base
  #attr_accessible :action, :description, :subject
  has_and_belongs_to_many :users, join_table: :permissions_users
end
