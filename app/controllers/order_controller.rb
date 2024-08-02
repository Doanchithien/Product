class OrderController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    order = Order.new(client_id: @current_client.id, product_id: params[:product_id])
    if order.save
      render json: { message: 'Client order product successfully', order: order }, status: :created
    else
      render json: { error: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    order = Order.find_by(client_id: @current_client.id, product_id: params[:product_id])
    if order&.destroy
      render json: { message: 'Client unorder product successfully' }, status: :ok
    else
      render json: { error: 'Unable to unorder product from client' }, status: :unprocessable_entity
    end
  end
end