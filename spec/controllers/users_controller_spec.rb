require 'rails_helper'
require 'json'
require 'jwt_auth'

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

  let(:user) { users('user_1') }

  def auth_user(user)
    request.headers['Authorization'] = JsonWebToken.encode(user_id: user.id)
  end

  describe 'GET #index' do
    it 'assigns all users as @users' do
      auth_user(user)
      get :index
      expect(response).to have_http_status(:success)
      assert_equal response.content_type, 'application/json'
      jdata = JSON.parse response.body
      expect(6).to eq(jdata['data'].length)
      expect(jdata['data'][0]['type']).to eq('users')
    end
    context 'me parameter' do
      it 'returns current user' do
        auth_user(user)
        get :index, params: { me: true }
        expect(response).to have_http_status(:success)
        assert_equal response.content_type, 'application/json'
        jdata = JSON.parse response.body
        expect(jdata['data']['type']).to eq('users')
        expect(jdata['data']['id']).to eq(user.id.to_s)
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      auth_user(user)
      get :show, params: { id: user.to_param }
      jdata = JSON.parse response.body
      expect(user.id.to_s).to eq(jdata['data']['id'])
      expect(response).to have_http_status(:success)
      expect(user.full_name).to eq(jdata['data']['attributes']['full-name'])
      expect(assigns(:user)).to eq(user)
    end

    it 'returns error for invalid user_id' do
      auth_user(user)
      get :show, params: { id: 'z' }
      expect(response).to have_http_status(404)
    end

    it 'returns error for unauthorised usage' do
      get :show, params: { id: 'z' }
      expect(response).to have_http_status(401)
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
            email: 'user11@mail.com'
          }
        }
      end

      def update_user
        update_data[:id] = user.to_param
        put :update, params: { id: user.to_param, data: update_data }
        user.reload
      end

      it 'updates the requested user' do
        auth_user(user)
        update_user
        expect(update_data[:attributes][:email]).to eq(user.email)
      end

      it 'fails to update without JWT' do
        update_user
        expect(response).to have_http_status(401)
      end

      it 'assigns the requested user as @user' do
        auth_user(user)
        put :update, params: { id: user.to_param, user: valid_data }
        expect(assigns(:user)).to eq(user)
      end

      it 'fails to update other users' do
        auth_user(user)
        put :update, params: { id: users('user_2').to_param, user: valid_data }
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      auth_user(user)
      expect {
        delete :destroy, params: {id: user.to_param}
      }.to change(User, :count).by(-1)
    end
  end
end
