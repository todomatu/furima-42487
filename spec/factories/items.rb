FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name }
    item_info { Faker::Lorem.paragraph(sentence_count: 3) }
    item_category_id { Faker::Number.within(range: 2..11) }
    item_sales_status_id { Faker::Number.within(range: 2..7) }
    item_shipping_fee_status_id { Faker::Number.within(range: 2..3) }
    item_prefecture_id { Faker::Number.within(range: 2..48) }
    item_scheduled_delivery_id { Faker::Number.within(range: 2..4) }
    item_price { Faker::Number.within(range: 300..9_999_999) }
    association :user
  end
end
