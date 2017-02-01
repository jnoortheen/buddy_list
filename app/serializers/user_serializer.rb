# Serialize User Model to JSON
class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :full_name, :email, :links

  has_many :friends

  def links
    { self: user_path(object.id) }
  end
end
