require 'rails_helper'

RSpec.describe PaymentController, type: :controller do
  let!(:client) { FactoryBot.create(:client) }
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:product) { FactoryBot.create(:product, brand_id: brand.id) }
  let!(:order) { FactoryBot.create(:order, product_id: product.id, client_id: client.id) }
  let!(:card) { FactoryBot.create(:card, client_id: client.id) }
  let(:valid_params) { { order_id: order.id, card_id: card.id } }
  let(:invalid_params) { { order_id: nil, card_id: nil } }
  before do
    session[:client_id] = client.id
  end

  describe 'POST #create' do
    context 'when payment is processed successfully' do
      before do
        allow_any_instance_of(PaymentService).to receive(:payment_process).and_return(true)
      end

      it 'returns a success message' do
        post :create, params: valid_params
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Transaction have complete successfully')
      end
    end

    context 'when payment processing raises an error' do
      before do
        allow_any_instance_of(PaymentService).to receive(:payment_process).and_raise(StandardError, 'Some error occurred')
      end

      it 'returns an error message' do
        post :create, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Some error occurred')
      end
    end

    context 'when parameters are invalid' do
      it 'returns an error message for missing parameters' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Transaction have to cancel')
      end
    end
  end
end
