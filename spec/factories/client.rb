FactoryBot.define do
  factory :client do
    email { "user@client.com" }
    name { "client" }
    password { "password123" }
  end
end