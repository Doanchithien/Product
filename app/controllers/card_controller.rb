class CardController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    card_number = generate_card_number
    card = Card.new(client_id: params[:client_id], card_number: card_number, pin_code: '1234')
    if card.save
      render json: { message: 'Client card created successfully' }, status: :created
    else
      render json: { errors: card.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def cancel_card
    card = Card.find_by(client_id: params[:client_id])
    if card&.update(status: false)
      render json: { message: 'Client cancel card successfully' }, status: :ok
    else
      render json: { error: 'Unable to cancel card from client' }, status: :unprocessable_entity
    end 
  end

  private

  def generate_card_number
    loop do
      number = rand(10_000_000..99_999_999)
      break number unless Card.exists?(card_number: number)
    end
  end
end