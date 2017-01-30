require 'rails_helper'

RSpec.describe Griddler::EmailsController, type: :controller do
  let(:from_user) { new_user }
  let(:to_user) { new_user }

  def new_user
    User.create(
      full_name: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
  end

  # return args for create POST
  def new_mail_args(subj)
    { from: from_user.email, body: 'hello', 
      subject: "#{subj} #{to_user.email}", to: 'hello@hello.com' }
  end

  describe 'POST #create' do
    context 'add friend' do
      it 'adds to friends list' do
        post :create, params: new_mail_args('add')
        from_user.reload
        expect(from_user.friendships.count).to eq(1)
        expect(from_user.friendships).to include(to_user)
        expect(response).to be_success
      end
    end
    context 'remove friend' do
      it 'removes user from friends list' do
        post :create, params: new_mail_args('remove')
        from_user.reload
        expect(response).to be_success
        expect(from_user.friendships.count).to eq(0)
        expect(from_user.friendships).not_to include(to_user)
      end
    end
  end
end
