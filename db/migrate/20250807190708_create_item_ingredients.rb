class CreateItemIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :item_ingredients do |t|
      t.references :order_item, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.boolean :added, null: false, default: true

      t.timestamps
    end
  end
end
