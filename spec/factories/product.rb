FactoryBot.define do
  factory :product do
    name { "product A" }
    description { "description" }
    logo_url { "" }
    released_at { "20240801" }
    price { 20 }
    currency { "EUR" }
  end
end
