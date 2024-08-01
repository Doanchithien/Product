class Brand < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :established_at, presence: true
end
