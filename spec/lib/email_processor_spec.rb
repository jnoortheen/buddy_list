require 'rails_helper'

# test emailprocessor library
RSpec.describe 'EmailProcessor' do
  let(:from_user) { new_user }
  let(:to_user) { new_user }

  def new_mail(subj)
    OpenStruct.new(from: from_user.email,
                   body: "#{to_user.email}", subject: subj)
  end

  def new_user
    User.create(full_name: Faker::Name.name,
              email: Faker::Internet.email,
              password: Faker::Internet.password)
  end

  context 'receiving email with subject' do
    context 'add friend' do
      it 'adds to friends list' do
        user, friend = EmailProcessor.new(new_mail('add friend')).process
        expect(user.friendships.count).to eq(1)
        expect(user.friendships).to include(friend)
      end
    end
    context 'remove friend' do
      it 'removes user from friends list' do
        user, friend = EmailProcessor.new(new_mail('remove friend')).process
        expect(user.friendships.count).to eq(0)
        expect(user.friendships).not_to include(friend)
      end
    end
  end
end
