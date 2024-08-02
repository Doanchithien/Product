class Admin::ClientController < Admin::AdminController
  skip_before_action :verify_authenticity_token
  
  def create
    client = Client.new(client_params)
    if client.save
      render json: { message: 'Client created successfully' }, status: :created
    else
      render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
  
  def client_params
    params.permit(:email, :name, :password)
  end
end