require 'rails_helper'

RSpec.describe Admin::ClientController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    session[:user_id] = user.id
  end
  let(:valid_params) { { email: 'user@client.com', password: 'password', name: 'client' } }
  let(:invalid_params) { { email: '', password: '', name: '' } }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Client' do
        expect {
          post :create, params: valid_params
        }.to change(Client, :count).by(1)
      end

      it 'renders a JSON response with the new client' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq({'message' => 'Client created successfully'})
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new client' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end
end
