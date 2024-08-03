class Order < ApplicationRecord
  belongs_to :client
  belongs_to :product

  validates :client_id, presence: true
  validates :product_id, presence: true
  has_many :transactions
end
