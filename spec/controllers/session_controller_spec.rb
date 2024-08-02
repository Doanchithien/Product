require 'rails_helper'

RSpec.describe SessionController, type: :controller do
  let(:client) { FactoryBot.create(:client) }
  describe 'POST #login' do
    context 'with valid credentials' do
      it 'logs in the client' do
        post :login, params: { email: client.email, password: client.password }
        
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Login successful')
        expect(session[:client_id]).to eq(client.id)
      end
    end

    context 'with invalid credentials' do
      it 'fails to log in the user' do
        post :login, params: { email: client.email, password: 'wrongpassword' }
        
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid email or password')
      end
    end
  end

  describe 'DELETE #logout' do
    before do
      post :login, params: { email: client.email, password: client.password }
    end

    it 'logs out the client' do
      delete :logout
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Logout successful')
      expect(session[:client_id]).to be_nil
    end
  end
end