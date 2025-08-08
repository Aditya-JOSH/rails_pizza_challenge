FactoryBot.define do
  factory :item_ingredient do
    association :order_item
    association :ingredient
    added { true }
  end
end
