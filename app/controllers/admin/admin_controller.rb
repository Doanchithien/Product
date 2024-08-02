class Admin::AdminController < ApplicationController
  before_action :authorize_request

  private

  def authorize_request
    @current_admin = User.find(session[:user_id]) if session[:user_id]
    return render json: { error: 'You are not login!' }, status: :unauthorized unless @current_admin
  end
end