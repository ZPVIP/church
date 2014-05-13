class Contact < ActiveRecord::Base
  has_many :group_contacts
  has_many :participated_groups, :through => :group_contacts, :source => :group
end
