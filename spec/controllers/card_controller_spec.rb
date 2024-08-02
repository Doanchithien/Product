require 'rails_helper'

RSpec.describe CardController, type: :controller do
  let!(:client) { FactoryBot.create(:client) }
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:product) { FactoryBot.create(:product, brand_id: brand.id) }
  let!(:client_product) { FactoryBot.create(:client_product, client_id: client.id, product_id: product.id) }

  before do
    session[:client_id] = client.id
  end

  describe 'POST #create' do
    let(:valid_params) { { client_product_id: client_product.id, purchase_details_pin: '1234' } }
    let(:invalid_params) { { client_product_id: nil, purchase_details_pin: '' } }

    context 'with valid params' do
      it 'creates a new card' do
        expect {
          post :create, params: valid_params
        }.to change(Card, :count).by(1)
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json['card']['client_product_id']).to eq(client_product.id)
      end
    end

    context 'with invalid params' do
      it 'does not create a new card' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Card, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json['error']).not_to be_empty
      end
    end
  end

  describe 'DELETE #cancel_card' do
    let!(:card) { create(:card, client_product_id: client_product.id) }

    context 'when the card exists' do
      it 'deletes the card' do
        expect {
          delete :cancel_card, params: { client_product_id: client_product.id }
        }.to change(Card, :count).by(-1)
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['message']).to eq('Cancel card successfully')
      end
    end

    context 'when the card does not exist' do
      it 'does not delete any card' do
        expect {
          delete :cancel_card, params: { client_product_id: 999 }
        }.not_to change(Card, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json['error']).to eq('Unable to cancel card from client')
      end
    end
  end
end