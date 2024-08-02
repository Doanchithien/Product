require 'rails_helper'

RSpec.describe Card, type: :model do
  let!(:client) { FactoryBot.create(:client) }
  it 'is valid with valid attributes' do
    card = FactoryBot.build(:card, client_id: client.id)
    expect(card).to be_valid
  end

  it 'is not valid without a client_id' do
    card = FactoryBot.build(:card, client_id: nil)
    expect(card).to_not be_valid
  end

  it 'is not valid without a card_number' do
    card = FactoryBot.build(:card, client_id: client.id, card_number: nil)
    expect(card).to_not be_valid
  end

  it 'is not valid with a duplicate card_number' do
    FactoryBot.create(:card, client_id: client.id, card_number: 11111111)
    card = FactoryBot.build(:card, client_id: client.id, card_number: 11111111)
    expect(card).to_not be_valid
  end
end