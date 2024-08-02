require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:client) { FactoryBot.create(:client) }
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:product) { FactoryBot.create(:product, brand_id: brand.id) }
  it 'is valid with valid attributes' do
    order = FactoryBot.build(:order, client_id: client.id, product_id: product.id)
    expect(order).to be_valid
  end

  it 'is not valid without a client_id' do
    order = FactoryBot.build(:order, client_id: nil, product_id: product.id)
    expect(order).to_not be_valid
  end

  it 'is not valid without a product_id' do
    order = FactoryBot.build(:order, client_id: client.id, product_id: nil)
    expect(order).to_not be_valid
  end
end