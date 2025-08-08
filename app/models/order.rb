class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :order_promotions, dependent: :destroy
  has_many :promotion_codes, through: :order_promotions
  belongs_to :discount_code, optional: true

  enum :state, { open: "OPEN", completed: "COMPLETED" }

  def calculate_total
    subtotal = order_items.sum do |item|
      item_price = item.calculate_price
      item_price * item.quantity
    end

    promotion_discount = apply_promotions

    discount_percentage = discount_code&.percentage || 0

    final_price = subtotal - promotion_discount
    final_price -= (final_price * (discount_percentage / 100)) if discount_percentage > 0

    update(total: final_price)
    final_price
  end

  def apply_promotions
    discount = 0

    grouped_items = order_items.group_by { |item| [ item.pizza_id, item.size ] }

    promotion_codes.each do |promo|
      target_items = grouped_items[[ promo.target_pizza_id, promo.target_size ]]
      next unless target_items

      total_quantity = target_items.sum(&:quantity)

      applications = total_quantity / promo.from_quantity
      next if applications == 0

      target_items.each do |item|
        base_price = item.pizza.price * SizeMultiplier.for(item.size)

        items_affected = [ item.quantity, applications * promo.from_quantity ].min
        discount_per_item = base_price * (1 - promo.to_quantity.to_f / promo.from_quantity)

        discount += discount_per_item * items_affected
      end
    end

    discount
  end

  def mark_as_completed
    update(state: "COMPLETED")
  end
end
