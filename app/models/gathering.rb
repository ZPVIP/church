class Gathering < ActiveRecord::Base
  has_many :contact_gatherings
  has_many :members, :through => :contact_gatherings, :source => :contact
end
