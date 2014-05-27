class User < ActiveRecord::Base
  has_and_belongs_to_many :permissions, join_table: :permissions_users
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def active_for_authentication?
    super && !self.blocked
  end

end
