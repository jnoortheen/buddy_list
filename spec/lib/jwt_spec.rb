require 'rails_helper'
require 'jwt_auth'

RSpec.describe 'JWT' do
  context 'valid token' do
    it 'decodes user correctly' do
      user = User.create!(full_name: 'user_1',
                       email: 'user_1@mail.com',
                       password: 'password')
      token = JsonWebToken.encode(user_id: user.id)

      expect(User.find(JsonWebToken.decode(token)[:user_id])).to eq(user)
    end
  end
end
