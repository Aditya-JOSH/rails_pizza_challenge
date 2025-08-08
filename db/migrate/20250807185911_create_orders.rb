class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :uuid, null: false
      t.string :state, null: false, default: 'OPEN'
      t.float :total
      t.references :discount_code, null: true, foreign_key: true

      t.timestamps
    end
    add_index :orders, :uuid, unique: true
  end
end
