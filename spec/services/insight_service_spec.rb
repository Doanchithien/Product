require 'rails_helper'

RSpec.describe InsightService, type: :service do
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:product) { FactoryBot.create(:product, brand_id: brand.id) }
  let!(:client1) { FactoryBot.create(:client, name: 'client 1', email: 'client1@example.com') }
  let!(:client2) { FactoryBot.create(:client, name: 'client 2', email: 'client2@example.com') }
  let!(:order1) { FactoryBot.create(:order, product_id: product.id, client_id: client1.id) }
  let!(:order2) { FactoryBot.create(:order, product_id: product.id, client_id: client1.id) }
  let!(:order3) { FactoryBot.create(:order, product_id: product.id, client_id: client2.id) }
  let!(:card1) { FactoryBot.create(:card, client_id: client1.id) }
  let!(:card2) { FactoryBot.create(:card, client_id: client1.id, status: false) }
  let!(:card3) { FactoryBot.create(:card, client_id: client2.id) }
  let!(:card4) { FactoryBot.create(:card, client_id: client2.id, status: false) }
  let!(:transaction1) { create(:transaction, card: card1, amount: 100, order: order1) }
  let!(:transaction2) { create(:transaction, card: card1, amount: 200, order: order2) }
  let!(:transaction3) { create(:transaction, card: card3, amount: 400, order: order3) }

  describe '.get_cancel_card_histories' do
    it 'returns the correct canceled card histories' do
      result = InsightService.get_cancel_card_histories

      expect(result.length).to eq(2)
      expect(result).to contain_exactly(
        { 'email' => 'client1@example.com', 'name' => 'client 1', 'status' => false },
        { 'email' => 'client2@example.com', 'name' => 'client 2', 'status' => false }
      )
    end
  end

  describe '.summary_payments_of_clients' do
    it 'returns the correct summary of payments' do
      result = InsightService.summary_payments_of_clients

      expect(result.length).to eq(2)
      expect(result).to contain_exactly(
        have_attributes('email' => 'client1@example.com', 'total_payment' => 300),
        have_attributes('email' => 'client2@example.com', 'total_payment' => 400)
      )
    end
  end

  describe '.get_payments_of_clients' do
    it 'returns the correct payments of clients' do
      result = InsightService.get_payments_of_clients

      expect(result.length).to eq(2)
      expect(result).to contain_exactly(
        { 'email' => 'client1@example.com', 'total_payment' => 300 },
        { 'email' => 'client2@example.com', 'total_payment' => 400 }
      )
    end
  end
end
