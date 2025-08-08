FactoryBot.define do
  factory :order do
    uuid { SecureRandom.uuid }
    state { "OPEN" }
    total { nil }
    discount_code { nil }
  end
end
