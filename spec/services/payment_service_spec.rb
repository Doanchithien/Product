require 'rails_helper'

RSpec.describe PaymentService, type: :service do
  let!(:client) { FactoryBot.create(:client) }
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:product) { FactoryBot.create(:product, brand_id: brand.id) }
  let!(:order) { FactoryBot.create(:order, product_id: product.id, client_id: client.id) }
  let!(:card) { FactoryBot.create(:card, client_id: client.id) }
  let!(:service) { PaymentService.new(order.id, card.id) }

  before do
    allow(Order).to receive(:find_by).with(id: order.id).and_return(order)
  end

  describe '#payment_process' do
    context 'when a valid transaction is processed' do
      it 'creates a new transaction with the correct attributes' do
        service.payment_process
        transaction = Transaction.last

        expect(transaction).to_not be_nil
        expect(transaction.order_id).to eq(order.id)
        expect(transaction.card_id).to eq(card.id)
        expect(transaction.amount).to eq(order.product.price_money.exchange_to('USD').fractional)
        expect(transaction.status).to eq('success')
      end
    end

    context 'when a transaction already exists with the status "inprogress"' do
      before do
        create(:transaction, order_id: order.id, card_id: card.id, status: 'inprogress')
      end

      it 'raises an error' do
        expect { service.payment_process }.to raise_error('Transaction have to cancel')
      end
    end

    context 'when the order does not exist' do
      before do
        allow(Order).to receive(:find_by).with(id: order.id).and_return(nil)
      end

      it 'raises an error' do
        expect { service.payment_process }.to raise_error('Transaction have to cancel')
      end
    end
  end

  describe '#convert_price_to_amount' do
    it 'converts the product price to the default currency' do
      service.convert_price_to_amount
      expect(service.instance_variable_get(:@amount)).to eq(order.product.price_money.exchange_to('USD').fractional)
    end
  end

  describe '#validate_transaction' do
    context 'when a transaction with status "inprogress" already exists' do
      before do
        create(:transaction, order_id: order.id, card_id: card.id, status: 'inprogress')
      end

      it 'raises an error' do
        expect { service.validate_transaction }.to raise_error('Transaction have to cancel')
      end
    end

    context 'when no transaction with status "inprogress" exists' do
      it 'does not raise an error' do
        expect { service.validate_transaction }.to_not raise_error
      end
    end
  end
end
