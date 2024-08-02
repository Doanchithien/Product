class ApplicationController < ActionController::Base
  before_action :authorize_client

  private

  def authorize_client
    @current_client = Client.find(session[:client_id]) if session[:client_id]
    return render json: { error: 'You are not login!' }, status: :unauthorized unless @current_client
  end
end
