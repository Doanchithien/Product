require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let!(:client) { FactoryBot.create(:client) }
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:product) { FactoryBot.create(:product, brand_id: brand.id) }
  let!(:order) { FactoryBot.create(:order, product_id: product.id, client_id: client.id) }
  let!(:card) { FactoryBot.create(:card, client_id: client.id) }

  context 'validations' do
    it 'is valid with valid params' do
      transaction = Transaction.new(amount: 100, order_id: order.id, card_id: card.id)
      expect(transaction).to be_valid
    end

    it 'is not valid without an amount' do
      transaction = Transaction.new(amount: nil, order_id: order.id, card_id: card.id)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:amount]).to include("can't be blank")
    end

    it 'is not valid with a non-numeric amount' do
      transaction = Transaction.new(amount: 'abc', order_id: order.id, card_id: card.id)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:amount]).to include('is not a number')
    end

    it 'is not valid with a negative amount' do
      transaction = Transaction.new(amount: -10, order_id: order.id, card_id: card.id)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:amount]).to include('must be greater than 0')
    end

    it 'is not valid without an order_id' do
      transaction = Transaction.new(amount: 100, order_id: nil, card_id: card.id)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:order_id]).to include("can't be blank")
    end

    it 'is not valid without a card_id' do
      transaction = Transaction.new(amount: 100, order_id: order.id, card_id: nil)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:card_id]).to include("can't be blank")
    end
  end
end
