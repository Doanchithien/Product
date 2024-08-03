FactoryBot.define do
  factory :transaction do
    amount { 10 }
    pay_time { Time.now }
    status { "inprogress" }
  end
end