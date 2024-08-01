require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let(:valid_params) { { email: 'user@example.com', password: 'password' } }
  let(:invalid_params) { { email: '', password: '' } }
  let(:user) { FactoryBot.create(:user) }

  describe 'POST #register' do
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :register, params: valid_params
        }.to change(User, :count).by(1)
        
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('User created successfully')
      end
    end

    context 'with invalid params' do
      it 'does not create a new User' do
        expect {
          post :register, params: invalid_params 
        }.to change(User, :count).by(0)
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("Email can't be blank", "Password can't be blank")
      end
    end
  end

  describe 'POST #login' do
    context 'with valid credentials' do
      it 'logs in the user' do
        post :login, params: { email: user.email, password: user.password }
        
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Login successful')
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'with invalid credentials' do
      it 'fails to log in the user' do
        post :login, params: { email: user.email, password: 'wrongpassword' }
        
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid email or password')
      end
    end
  end

  describe 'DELETE #logout' do
    before do
      post :login, params: { email: user.email, password: user.password }
    end

    it 'logs out the user' do
      delete :logout
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Logout successful')
      expect(session[:user_id]).to be_nil
    end
  end
end
