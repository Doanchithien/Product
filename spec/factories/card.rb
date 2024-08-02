FactoryBot.define do
  factory :card do
    activation_number { SecureRandom.hex(10) }
    purchase_details_pin { 1234 }
  end
end