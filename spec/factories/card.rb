FactoryBot.define do
  factory :card do
    card_number { rand(10_000_000..99_999_999) }
    pin_code { '1234' }
  end
end