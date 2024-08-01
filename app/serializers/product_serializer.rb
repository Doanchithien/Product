class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :logo_url, :released_at, :brand_id, :price, :currency 
end
