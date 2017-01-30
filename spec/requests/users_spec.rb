require 'rails_helper'
require 'jwt_auth'

RSpec.describe 'Users', type: :request do
  fixtures :users

  let(:user) { users('user_1') }

  def get_token(user)
    JsonWebToken.encode(user_id: user.id)
  end

  describe 'GET /users' do
    it 'return all users serialized' do
      headers = { 'Authorization' => get_token(user) }
      get users_path, headers: headers
      expect(response).to have_http_status(200)
    end
  end
end
