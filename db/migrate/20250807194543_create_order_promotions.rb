class CreateOrderPromotions < ActiveRecord::Migration[8.0]
  def change
    create_table :order_promotions do |t|
      t.references :order, null: false, foreign_key: true
      t.references :promotion_code, null: false, foreign_key: true

      t.timestamps
    end
    add_index :order_promotions, [ :order_id, :promotion_code_id ]
  end
end
