require 'rails_helper'

RSpec.describe CardController, type: :controller do
  let(:client) { FactoryBot.create(:client) }
  let(:card) { FactoryBot.create(:card, client_id: client.id) }

  before do
    session[:client_id] = client.id
  end

  describe 'POST #create' do
    context 'when creates a new card successfully' do
      it 'returns a success message' do
        expect {
          post :create, params: { client_id: client.id }
        }.to change(Card, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Client card created successfully')
      end
    end

    context 'when creates a new card cause errors' do
      it 'returns an error message' do
        post :create, params: { client_id: nil }

        expect(response).to have_http_status(:unprocessable_entity)        
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe 'PATCH #cancel_card' do
    context 'when cancel card successfully' do
      before { card }

      it 'returns a success message' do
        patch :cancel_card, params: { client_id: client.id }
        card.reload
        expect(card.status).to eq(false)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Client cancel card successfully')
      end
    end

    context 'when cancel card unsuccessfully' do
      it 'returns an error message' do
        patch :cancel_card, params: { client_id: -1 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Unable to cancel card from client')
      end
    end
  end
end
