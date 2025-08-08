FactoryBot.define do
  factory :pizza do
    sequence(:name) { |n| "Pizza #{n}" }
    price { 5.0 }
  end
end
