class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :pizza
  has_many :item_ingredients, dependent: :destroy

  validates :size, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def calculate_price
    base_price = pizza.price * SizeMultiplier.for(size)

    extras_price = item_ingredients.where(added: true).sum do |item_ingredient|
      item_ingredient.ingredient.price * SizeMultiplier.for(size)
    end

    base_price + extras_price
  end
end
