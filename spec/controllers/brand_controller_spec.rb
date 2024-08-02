require 'rails_helper'

RSpec.describe Admin::BrandController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    session[:user_id] = user.id
  end
  let(:valid_params) do
    {
      name: 'Brand A',
      description: 'A description for brand',
      logo_url: '/public/logo.png',
      established_at: '2024-08-01',
      country: 'VN'
    }
  end

  let(:invalid_params) do
    {
      name: '',
      description: 'Description',
      logo_url: '/public/logo.png',
      established_at: '',
      country: 'VN'
    }
  end

  describe 'GET #brand_list' do
    it 'returns a success response' do
      brand = FactoryBot.build(:brand)
      get :brand_list
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'POST #create_brand' do
    context 'with valid params' do
      it 'creates a new Brand' do
        expect {
          post :create_brand, params: valid_params
        }.to change(Brand, :count).by(1)
      end

      it 'renders a JSON response with the new brand' do
        post :create_brand, params: valid_params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq({'message' => 'Brand created successfully'})
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new brand' do
        post :create_brand, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end
end
