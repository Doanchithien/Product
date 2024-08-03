class Transaction < ApplicationRecord
  belongs_to :order
  belongs_to :card

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :order_id, presence: true
  validates :card_id, presence: true
end
