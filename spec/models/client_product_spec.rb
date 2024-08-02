require 'rails_helper'

RSpec.describe ClientProduct, type: :model do
  let!(:client) { FactoryBot.create(:client) }
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:product) { FactoryBot.create(:product, brand_id: brand.id) }
  it 'is valid with valid attributes' do
    client_product = FactoryBot.build(:client_product, client_id: client.id, product_id: product.id)
    expect(client_product).to be_valid
  end

  it 'is not valid without a client_id' do
    client_product = FactoryBot.build(:client_product, client_id: nil, product_id: product.id)
    expect(client_product).to_not be_valid
  end

  it 'is not valid without a product_id' do
    client_product = FactoryBot.build(:client_product, client_id: client.id, product_id: nil)
    expect(client_product).to_not be_valid
  end
end