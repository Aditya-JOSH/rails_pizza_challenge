class ItemIngredient < ApplicationRecord
  belongs_to :order_item
  belongs_to :ingredient
end
