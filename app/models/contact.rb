class Contact < ActiveRecord::Base
  has_many :contact_groups
  has_many :participated_groups, :through => :contact_groups, :source => :group
  has_many :contact_gatherings
  has_many :participated_gatherings, :through => :contact_gatherings, :source => :gathering
  belongs_to :user
  has_many :user_contacts
  has_many :updaters, :through => :user_contacts, :source => :user
  
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/,     message: "is not a valid email address" }, allow_blank: true, uniqueness: true
  validates :name, :gender, presence: true
  validates :name, uniqueness: { scope: :birthday,    message: "already exists" }
end
