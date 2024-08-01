class UserController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def register
    user = User.new(user_params)
    if user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: 'Login successful' }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  def logout
    session.delete(:user_id)
    render json: { message: 'Logout successful' }, status: :ok
  end
  
  private
  
  def user_params
    params.permit(:email, :password)
  end
end
