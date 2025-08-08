class FixPromotionCodesTargetPizzaForeignKey < ActiveRecord::Migration[8.0]
  def change
      remove_foreign_key :promotion_codes, :target_pizzas

      add_foreign_key :promotion_codes, :pizzas, column: :target_pizza_id
  end
end
