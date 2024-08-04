class PaymentService
  STATUS = { start: "inprogress", done: "success" }

  def initialize(order_id, card_id)
    @order_id = order_id
    @card_id = card_id
    @default_currency = "USD"
  end

  def payment_process
    validate_transaction
    convert_price_to_amount
    create_transaction
    complete_transaction
  end

  def create_transaction
    @transaction = Transaction.new(card_id: @card_id, order_id: @order_id, amount: @amount, pay_time: Time.now)
  end

  def convert_price_to_amount
    product_order = Order.find_by(id: @order_id)&.product
    raise "Transaction have to cancel" unless product_order
    @amount = product_order.price_money.exchange_to(@default_currency).fractional
  end

  def complete_transaction
    @transaction.status = STATUS[:done]
    @transaction.save
  end

  def validate_transaction
    card = Card.find_by(id: @card_id)
    raise "Cannot found your card" unless card
    raise "Your card have been cancel" unless card&.status
    raise "Transaction have to cancel" if Transaction.exists?(order_id: @order_id, card_id: @card_id, status: 'inprogress')
  end
end