FactoryBot.define do
  Faker::Config.locale = 'ja'
  factory :order_address do
    item_id { Faker::Number.number(digits: 12) }
    user_id { Faker::Number.number(digits: 12) }
    postal_code { Faker::Address.postcode }
    item_prefecture_id { rand(2..48) }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.number(digits: [10, 11].sample) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
