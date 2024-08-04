class Admin::InsightController < Admin::AdminController
  skip_before_action :verify_authenticity_token

  def cancel_card_histories
    result = InsightService.get_cancel_card_histories
    render json: result, status: :ok
  end

  def payments_of_clients
    result = InsightService.get_payments_of_clients
    render json: result, status: :ok
  end
end