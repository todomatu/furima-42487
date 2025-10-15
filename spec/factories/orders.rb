FactoryBot.define do
  factory :order do
    token { 'tok_abcdefghijk00000000000000000' }
    association :item
    association :user
  end
end
