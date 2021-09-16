FactoryBot.define do
  factory :customer, class: Customer do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
  end
end
