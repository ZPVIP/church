class Group < ActiveRecord::Base
  has_many :contact_groups
  has_many :members, dependent: :restrict_with_error, through: :contact_groups, source: :contact
end
