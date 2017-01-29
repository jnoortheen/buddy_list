require 'rails_helper'
require 'json'

RSpec.describe UsersController, type: :controller do
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

  describe 'GET #index' do
    it 'assigns all users as @users' do
      get :index
      assert_response :success
      assert_equal response.content_type, 'application/json'
      jdata = JSON.parse response.body
      assert_equal 6, jdata['data'].length
      assert_equal jdata['data'][0]['type'], 'users'
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      user = users('user_1')
      get :show, params: { id: user.to_param }
      jdata = JSON.parse response.body
      expect(user.id.to_s).to eq(jdata['data']['id'])
      expect(response).to have_http_status(:success)
      expect(user.full_name).to eq(jdata['data']['attributes']['full-name'])
      expect(assigns(:user)).to eq(user)
    end

    it 'returns error for invalid user_id' do
      get :show, params: { id: 'z' }
      expect(response).to have_http_status(404)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect { post :create, params: { data: valid_data } }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, params: { data: valid_data }
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, params: { user: invalid_data }
        expect(response).to have_http_status(422)
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:update_data) do
        {
          type: 'users',
          attributes:
          {
            full_name: 'user_1',
            email: 'user11@mail.com'
          }
        }
      end

      it 'updates the requested user' do
        user = User.create! valid_data[:attributes]
        update_data[:id] = user.to_param
        put :update, params: { id: user.to_param, data: update_data }
        user.reload
        expect(update_data[:attributes][:email]).to eq(user.email)
      end

      it 'assigns the requested user as @user' do
        user = User.create! valid_data[:attributes]
        put :update, params: { id: user.to_param, user: valid_data }
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'with invalid params' do
      it 'assigns the user as @user' do
        user = User.create! valid_data[:attributes]
        put :update, params: { id: user.to_param, user: invalid_data }
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_data[:attributes]
      expect {
        delete :destroy, params: {id: user.to_param}
      }.to change(User, :count).by(-1)
    end
  end
end
