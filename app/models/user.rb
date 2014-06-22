class User < ActiveRecord::Base
  has_many :user_permissions
  has_many :permissions, through: :user_permissions

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def active_for_authentication?
    super && !self.blocked
  end

end
