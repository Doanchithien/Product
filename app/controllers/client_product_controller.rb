class ClientProductController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    client_product = ClientProduct.new(client_id: @current_client.id, product_id: params[:product_id])
    if client_product.save
      render json: { message: 'Product assigned to client successfully', client_product: client_product }, status: :created
    else
      render json: { error: client_product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    client_product = ClientProduct.find_by(client_id: @current_client.id, product_id: params[:product_id])
    if client_product&.destroy
      render json: { message: 'Product unassigned from client successfully' }, status: :ok
    else
      render json: { error: 'Unable to unassign product from client' }, status: :unprocessable_entity
    end
  end
end