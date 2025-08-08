class DiscountCode < ApplicationRecord
  has_many :orders

  validates :code, presence: true, uniqueness: true
  validates :percentage, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
end
