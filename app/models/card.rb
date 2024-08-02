class Card < ApplicationRecord
  belongs_to :client_product

  validates :activation_number, presence: true, uniqueness: true
  validates :client_product_id, presence: true
  validates :purchase_details_pin, presence: true
end
