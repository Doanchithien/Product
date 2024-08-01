class BrandSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :logo_url, :established_at, :country
end
