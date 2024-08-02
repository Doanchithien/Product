require 'rails_helper'

RSpec.describe Admin::ProductController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    session[:user_id] = user.id
  end
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:product) { FactoryBot.create(:product, brand: brand) }

  describe 'GET #product_list' do
    it 'returns a list of products' do
      get :product_list
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(Product.count)
    end
  end

  describe 'POST #create_product' do
    context 'with valid params' do
      let(:valid_product_params) do
        {
          name: "product new",
          description: "description",
          logo_url: "public/photo.png",
          released_at: "20240801",
          price: 200000,
          currency: "VND",
          brand_id: brand.id
        }
      end
      it 'creates a new product' do
        expect {
          post :create_product, params: valid_product_params
        }.to change(Product, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Product created successfully')
      end
    end

    context 'with invalid params' do
      let(:invalid_product_params) do
        {
          name: "",
          description: "description",
          logo_url: "public/photo.png",
          released_at: "",
          price: 0,
          currency: "",
          brand_id: brand.id
        }
      end
      it 'does not create a new product' do
        expect {
          post :create_product, params: invalid_product_params
        }.to_not change(Product, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("Name can't be blank")
      end
    end
  end

  describe 'PATCH #update_product' do
    context 'with valid params' do
      let(:valid_product_params) do
        {
          product_id: product.id,
          name: 'Updated product name'
        }
      end
      it 'updates the product' do
        put :update_product, params: valid_product_params
        product.reload
        expect(response).to have_http_status(:ok)
        expect(product.name).to eq('Updated product name')
        expect(JSON.parse(response.body)['message']).to eq('Product updated successfully')
      end
    end

    context 'with invalid params' do
      let(:invalid_product_params) do
        {
          product_id: product.id,
          name: ''
        }
      end
      it 'does not update the product' do
        put :update_product, params: invalid_product_params
        product.reload
        expect(response).to have_http_status(:unprocessable_entity)
        expect(product.name).to_not be_nil
        expect(JSON.parse(response.body)['error']).to include("Name can't be blank")
      end
    end
  end

  describe 'DELETE #delete_product' do
    it 'deletes the product' do
      expect {
        delete :delete_product, params: { product_id: product.id }
      }.to change(Product, :count).by(-1)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Product successfully deleted')
    end
  end

  describe '#set_product' do
    it 'return Product not found when delete/update but cannot find product' do
      put :update_product, params: { product_id: 9999 }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to include("Product not found")
    end
  end
end
