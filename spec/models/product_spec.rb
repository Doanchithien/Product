require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:brand) { FactoryBot.create(:brand) }

  it 'is valid with valid attributes' do
    product = FactoryBot.build(:product, brand_id: brand.id)
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    product = FactoryBot.build(:product, brand_id: brand.id, name: nil)
    expect(product).to_not be_valid
  end

  it 'is not valid without an released_at' do
    product = FactoryBot.build(:product, brand_id: brand.id, released_at: nil)
    expect(product).to_not be_valid
  end

  it 'is not valid with a duplicate name' do
    FactoryBot.create(:product, brand_id: brand.id, name: 'Product A')
    product = FactoryBot.build(:product, brand_id: brand.id, name: 'Product A')
    expect(product).to_not be_valid
  end

  it 'is not valid without a price' do
    product = FactoryBot.build(:product, brand_id: brand.id, price: nil)
    expect(product).to_not be_valid
  end

  it 'is not valid without a currency' do
    product = FactoryBot.build(:product, brand_id: brand.id, currency: nil)
    expect(product).to_not be_valid
  end

  it 'is not valid with a price equal 0' do
    product = FactoryBot.build(:product, brand_id: brand.id, price: 0)
    expect(product).to_not be_valid
  end
end
