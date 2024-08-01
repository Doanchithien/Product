class ProductController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_product, only: [:update_product, :delete_product]

  def product_list
    products = Product.all
    render json: products
  end

  def create_product
    product = Product.new(product_params)
    if product.save
      render json: { message: 'Product created successfully' }, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_product
    if @product.update(product_params)
      render json: { message: 'Product updated successfully' }, status: :ok
    else
      render json: { error: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete_product
    @product.destroy
    render json: { message: 'Product successfully deleted' }, status: :ok
  end

  private

  def product_params
    params.permit(:name, :description, :logo_url, :released_at, :price, :currency, :brand_id)
  end

  def set_product
    @product = Product.find_by_id(params[:product_id])
    return render json: { error: 'Product not found' }, status: :unprocessable_entity unless @product
  end
end
