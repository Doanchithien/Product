class Brand < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :established_at, presence: true
end
