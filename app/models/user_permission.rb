class UserPermission < ActiveRecord::Base
  belongs_to :user
  belongs_to :permission
end
