FactoryBot.define do
  factory :discount_code do
    sequence(:code) { |n| "DISCOUNT#{n}" }
    percentage { 5 }
  end
end
