class CardController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    activation_number = generate_unique_activation_number
    card = Card.new(card_params.merge(activation_number: activation_number))
    if card.save
      render json: { message: 'Card product successfully', card: card }, status: :created
    else
      render json: { error: card.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def cancel_card
    card = Card.find_by(client_product_id: params[:client_product_id])
    if card&.destroy
      render json: { message: 'Cancel card successfully' }, status: :ok
    else
      render json: { error: 'Unable to cancel card from client' }, status: :unprocessable_entity
    end
  end

  private

  def card_params
    params.permit(:client_product_id, :purchase_details_pin)
  end

  def generate_unique_activation_number
    loop do
      token = SecureRandom.hex(10)
      break token unless Card.exists?(activation_number: token)
    end
  end
end