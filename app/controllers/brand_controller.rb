class BrandController < ApplicationController
  skip_before_action :verify_authenticity_token

  def brand_list
    brands = Brand.all
    render json: brands
  end

  def create_brand
    brand = Brand.new(brand_params)
    if brand.save
      render json: { message: 'Brand created successfully' }, status: :created
    else
      render json: { errors: brand.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def brand_params
    params.permit(:name, :description, :logo_url, :established_at, :country)
  end
end
