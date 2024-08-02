class StateManagementController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_brand, only: [:update_state_brand]
  before_action :set_product, only: [:update_state_product]

  def update_state_brand
    stt_mgmt_service = StateManagementService.new(@brand)
    begin
      update_stt = stt_mgmt_service.update_state(convert_to_boolean(params[:status]))
    rescue Exception => e
      return render json: { error: e.message }, status: :unprocessable_entity
    end
    render json: { message: 'Brand status updated successfully' }, status: :ok
  end

  def update_state_product
    stt_mgmt_service = StateManagementService.new(@product)
    begin
      update_stt = stt_mgmt_service.update_state(convert_to_boolean(params[:status]))
    rescue Exception => e
      return render json: { error: e.message }, status: :unprocessable_entity
    end
    render json: { message: 'Product status updated successfully' }, status: :ok
  end

  private

  def convert_to_boolean(value)
    value.downcase == 'true' if %w[true false].include? value.downcase
  end

  def set_brand
    @brand = Brand.find_by_id(params[:brand_id])
    return render json: { error: 'Brand not found' }, status: :unprocessable_entity unless @brand
  end

  def set_product
    @product = Product.find_by_id(params[:product_id])
    return render json: { error: 'Product not found' }, status: :unprocessable_entity unless @product
  end
end