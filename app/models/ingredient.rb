class Ingredient < ApplicationRecord
  has_many :item_ingredients

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
