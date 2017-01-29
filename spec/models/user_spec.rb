require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context 'with valid parameters' do
      it 'creates new user record' do
        expect do
          User.create!(full_name: 'user_1',
                       email: 'noor@mail.com',
                       password: 'password')
        end.to change(User, :count).by(1)
      end
    end
  end
end
