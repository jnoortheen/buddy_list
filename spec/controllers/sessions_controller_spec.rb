require 'rails_helper'
require 'json'
require 'jwt_auth'

RSpec.describe SessionsController, type: :controller do
  fixtures :users
  let(:valid_data) do
    {
      type: 'users',
      attributes:
      {
        full_name: 'user_1',
        email: 'noor@mail.com',
        password: 'password'
      }
    }
  end

  let(:invalid_data) { { data: { type: 'users' } } }

  describe 'POST #login' do
    context 'with correct credentials' do
      it 'return JWT' do
        user = User.create!(valid_data[:attributes])
        post :login, params: {
          email: user.email,
          password: valid_data[:attributes][:password]
        }

        jdata = JSON.parse response.body
        expect(response).to have_http_status(:success)
        expect(jdata).to have_key('access_token')
        expect(JsonWebToken.decode(jdata['access_token'])[:user_id]).to eq(user.id)
      end
    end
    context 'invalid credentials' do
      it 'returns error message' do
        user = User.create!(valid_data[:attributes])
        post :login, params: {
          email: user.email,
          password: 'pwd123'
        }

        jdata = JSON.parse response.body
        expect(response).to have_http_status(:unauthorized)
        expect(jdata).to_not have_key('access_token')
      end
    end
  end
end
