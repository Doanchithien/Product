class Product < ApplicationRecord
  belongs_to :brand

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true
  validates :name, presence: true, uniqueness: true
  validates :released_at, presence: true
  validates :brand_id, presence: true
end
