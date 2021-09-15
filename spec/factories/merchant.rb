FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Name.unique.name }
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
  end
end
