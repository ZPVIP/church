class Group < ActiveRecord::Base
  has_many :group_contacts
  has_many :members, :through => :group_contacts, :source => :contact
end
