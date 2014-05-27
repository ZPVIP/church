class Group < ActiveRecord::Base
  has_many :contact_groups
  has_many :members, :through => :contact_groups, :source => :contact
end
