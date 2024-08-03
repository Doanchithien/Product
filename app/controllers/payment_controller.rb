class PaymentController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    begin
      stt_of_payment_process = payment_service.payment_process
    rescue Exception => e
      return render json: { error: e.message }, status: :unprocessable_entity
    end
    
    render json: { message: 'Transaction have complete successfully' }, status: :ok
  end

  private

  def payment_service
    PaymentService.new(params[:order_id], params[:card_id])
  end
end