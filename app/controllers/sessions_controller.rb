require 'jwt_auth'

# to manage user login
class SessionsController < ApplicationController
  skip_before_action :set_current_user, :authenticate_request

  def login
    puts get_identifier
    user = User.find_by email: get_identifier
    if user && user.authenticate(params[:password])
      render json: { access_token: JsonWebToken.encode(user_id: user.id) }
    else
      user ||= User.new
      user.errors.add(:email, 'Invalid credentials')
      render_error(user, :unauthorized)
    end
  end

  private

  def get_identifier
    params[:email] || params[:username]
  end
end
