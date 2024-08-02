class SessionController < ApplicationController
  skip_before_action :authorize_client, only: [:login]
  skip_before_action :verify_authenticity_token

  def login
    client = Client.find_by(email: params[:email])
    if client&.authenticate(params[:password])
      session[:client_id] = client.id
      render json: { message: 'Login successful' }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  def logout
    session.delete(:client_id)
    render json: { message: 'Logout successful' }, status: :ok
  end
end