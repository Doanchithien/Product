class InsightService
  def self.get_cancel_card_histories
    results = []
    cancel_cards =  Card.includes(:client).where(status: false)
    cancel_cards.each do |card|
      result = {}
      result['email'] = card.client.email
      result['name'] = card.client.name
      result['status'] = card.status
      results << result
    end
    results
  end

  def self.summary_payments_of_clients
    raw_sql = <<-SQL
      SELECT cl.email, SUM(t.amount) as total_payment
      FROM transactions t
      INNER JOIN cards c ON t.card_id = c.id
      INNER JOIN clients cl ON c.client_id = cl.id
      GROUP BY cl.email;
    SQL
  
    Transaction.find_by_sql(raw_sql)
  end

  def self.get_payments_of_clients
    results = []
    payments = summary_payments_of_clients
    
    payments.each do |payment|
      result = {}
      result["email"] = payment.email
      result["total_payment"] = payment.total_payment
      results << result
    end
    results
  end
end