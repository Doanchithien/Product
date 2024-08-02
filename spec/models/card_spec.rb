require 'rails_helper'

RSpec.describe Card, type: :model do
  let!(:client) { FactoryBot.create(:client) }
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:product) { FactoryBot.create(:product, brand_id: brand.id) }
  let!(:client_product) { FactoryBot.create(:client_product, client_id: client.id, product_id: product.id) }
  it 'is valid with valid attributes' do
    card = FactoryBot.build(:card, client_product_id: client_product.id)
    expect(card).to be_valid
  end

  it 'is not valid without a client_product_id' do
    card = FactoryBot.build(:card, client_product_id: nil)
    expect(card).to_not be_valid
  end

  it 'is not valid without an activation_number' do
    card = FactoryBot.build(:card, client_product_id: client_product.id, activation_number: nil)
    expect(card).to_not be_valid
  end

  it 'is not valid without a purchase_details_pin' do
    card = FactoryBot.build(:card, client_product_id: client_product.id, purchase_details_pin: nil)
    expect(card).to_not be_valid
  end

  it 'is not valid without a duplicate activation_number' do
    FactoryBot.create(:card, client_product_id: client_product.id, activation_number: '02b7cc83530b5b97b8aa')
    card = FactoryBot.build(:card, client_product_id: client_product.id, activation_number: '02b7cc83530b5b97b8aa')
    expect(card).to_not be_valid
  end
end