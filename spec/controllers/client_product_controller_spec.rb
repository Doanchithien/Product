require 'rails_helper'

RSpec.describe ClientProductController, type: :controller do
  let(:client) { FactoryBot.create(:client) }
  let(:brand) { FactoryBot.create(:brand) }
  let(:product) { FactoryBot.create(:product, brand_id: brand.id) }
  let(:client_product) { FactoryBot.create(:client_product, client_id: client.id, product_id: product.id) }

  before do
    session[:client_id] = client.id
  end

  describe 'POST #create' do
    context 'when the product is assigned successfully' do
      it 'returns a success message' do
        expect {
          post :create, params: { product_id: product.id }
        }.to change(ClientProduct, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Product assigned to client successfully')
      end
    end

    context 'when the product assignment fails' do
      it 'returns an error message' do
        post :create, params: { product_id: -1 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the product is unassigned successfully' do
      before { client_product }

      it 'returns a success message' do
        expect {
          delete :destroy, params: { product_id: product.id }
        }.to change(ClientProduct, :count).by(-1)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Product unassigned from client successfully')
      end
    end

    context 'when the product unassignment fails' do
      it 'returns an error message' do
        delete :destroy, params: { product_id: -1 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Unable to unassign product from client')
      end
    end
  end
end
