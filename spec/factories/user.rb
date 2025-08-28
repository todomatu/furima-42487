FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    last_name_kana { Faker::Japanese::Name.last_kana }
    first_name_kana { Faker::Japanese::Name.first_kana }
    birth_date { Faker::Date.birthday }
  end
end
