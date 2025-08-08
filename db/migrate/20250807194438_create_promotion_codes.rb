class CreatePromotionCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :promotion_codes do |t|
      t.string :code, null: false
      t.references :target_pizza, null: false, foreign_key: true
      t.string :target_size, null: false
      t.integer :from_quantity, null: false
      t.integer :to_quantity, null: false

      t.timestamps
    end
    add_index :promotion_codes, :code, unique: true
  end
end
