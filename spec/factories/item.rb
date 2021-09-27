FactoryBot.define do
  factory :item, class: Item do
    name { Faker::Lorem.sentence(word_count: 2) }
    description { Faker::Lorem.sentence(word_count: 7) }
    unit_price { 5 }
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
  end
end
