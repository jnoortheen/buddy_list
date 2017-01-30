require 'jwt_auth'

# to manage user login
class SessionsController < ApplicationController
  skip_before_action :set_current_user, :authenticate_request

  def signin
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      render json: { access_token: JsonWebToken.encode(user_id: user.id) }
    else
      user = User.new
      user.errors.add(:email, 'Invalid credentials')
      render_error(user, :unauthorized)
    end
  end
end
