# User resource model
class User < ApplicationRecord
  has_secure_password

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, presence: true

  def add_friend(user)
    return if friends.include?(user)
    friends << user
  end

  def remove_friend(user)
    return unless friends.include?(user)
    friends.delete(user)
  end
end
