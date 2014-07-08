class Permission < ActiveRecord::Base
  has_many :user_permissions
  has_many :users, dependent: :restrict_with_error, through: :user_permissions
end
