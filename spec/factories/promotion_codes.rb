FactoryBot.define do
  factory :promotion_code do
    sequence(:code) { |n| "PROMO#{n}" }
    association :target_pizza, factory: :pizza
    target_size { "Small" }
    from_quantity { 2 }
    to_quantity { 1 }
  end
end
