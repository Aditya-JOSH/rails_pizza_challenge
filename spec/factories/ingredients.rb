FactoryBot.define do
  factory :ingredient do
    sequence(:name) { |n| "Ingredient #{n}" }
    price { 1.5 }
  end
end
