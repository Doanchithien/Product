class Client < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :name, presence: true
  validates :password, presence: true

  has_many :client_products
  has_many :products, through: :client_products
  has_one :card
end
