FactoryBot.define do
  factory :order_promotion do
    association :order
    association :promotion_code
  end
end
