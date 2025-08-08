FactoryBot.define do
  factory :order_item do
    association :order
    association :pizza
    size { [ "Small", "Medium", "Large" ].sample }
    quantity { 1 }
  end
end
