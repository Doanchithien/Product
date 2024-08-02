require 'rails_helper'

RSpec.describe Admin::StateManagementController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    session[:user_id] = user.id
  end
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:product) { FactoryBot.create(:product, brand_id: brand.id) }

  describe 'PATCH #update_state_brand' do
    context 'with valid parameters' do
      it 'updates the brand status to active' do
        put :update_state_brand, params: { brand_id: brand.id, status: 'true' }
        brand.reload
        expect(brand.active).to eq(true)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Brand status updated successfully')
      end

      it 'updates the brand status to inactive' do
        put :update_state_brand, params: { brand_id: brand.id, status: 'false' }
        brand.reload
        expect(brand.active).to eq(false)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Brand status updated successfully')
      end
    end

    context 'with invalid brand_id' do
      it 'returns an error if the brand is not found' do
        put :update_state_brand, params: { brand_id: -1, status: 'true' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Brand not found')
      end
    end

    context 'with invalid status params' do
      it 'returns an error if the status params is invalid' do
        put :update_state_brand, params: { brand_id: brand.id, status: 'invalid' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Invalid state')
      end
    end
  end

  describe 'POST #update_state_product' do
    context 'with valid parameters' do
      it 'updates the product status to active' do
        put :update_state_product, params: { product_id: product.id, status: 'true' }
        product.reload
        expect(product.active).to eq(true)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Product status updated successfully')
      end

      it 'updates the product status to inactive' do
        put :update_state_product, params: { product_id: product.id, status: 'false' }
        product.reload
        expect(product.active).to eq(false)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Product status updated successfully')
      end
    end

    context 'with invalid product_id' do
      it 'returns an error if the product is not found' do
        put :update_state_product, params: { product_id: -1, status: 'true' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Product not found')
      end
    end

    context 'with invalid status params' do
      it 'returns an error if the status params is invalid' do
        put :update_state_product, params: { product_id: product.id, status: 'invalid' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Invalid state')
      end
    end
  end
end
