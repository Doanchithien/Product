class ApplicationController < ActionController::Base
  before_action :authorize_request

  private

  def authorize_request
    @current_user = User.find(session[:user_id]) if session[:user_id]
    return render json: { error: 'You are not login!' }, status: :unauthorized unless @current_user
  end
end
