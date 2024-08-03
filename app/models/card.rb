class Card < ApplicationRecord
  belongs_to :client
  has_many :transactions

  validates :card_number, presence: true, uniqueness: true
  validates :client_id, presence: true
end
