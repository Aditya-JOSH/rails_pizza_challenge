class PromotionCode < ApplicationRecord
  belongs_to :target_pizza, class_name: "Pizza"
  has_many :order_promotions
  has_many :orders, through: :order_promotions

  validates :code, presence: true, uniqueness: true
  validates :target_size, presence: true
  validates :from_quantity, presence: true, numericality: { greater_than: 0 }
  validates :to_quantity, presence: true, numericality: { greater_than: 0 }
end
