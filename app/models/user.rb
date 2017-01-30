# User resource model
class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :friendships,
                          class_name: 'User',
                          join_table:  :friends_users,
                          foreign_key: :user_id,
                          association_foreign_key: :friend_id

  validates :email, presence: true

  def add_friend(user)
    return if friendships.include?(user)
    friendships << user
  end

  def remove_friend(user)
    return unless friendships.include?(user)
    friendships.delete(user)
  end
end
