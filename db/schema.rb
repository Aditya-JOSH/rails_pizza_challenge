# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_08_085215) do
  create_table "discount_codes", force: :cascade do |t|
    t.string "code", null: false
    t.decimal "percentage", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_discount_codes_on_code", unique: true
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ingredients_on_name", unique: true
  end

  create_table "item_ingredients", force: :cascade do |t|
    t.integer "order_item_id", null: false
    t.integer "ingredient_id", null: false
    t.boolean "added", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_item_ingredients_on_ingredient_id"
    t.index ["order_item_id"], name: "index_item_ingredients_on_order_item_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "pizza_id", null: false
    t.string "size", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["pizza_id"], name: "index_order_items_on_pizza_id"
  end

  create_table "order_promotions", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "promotion_code_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id", "promotion_code_id"], name: "index_order_promotions_on_order_id_and_promotion_code_id"
    t.index ["order_id"], name: "index_order_promotions_on_order_id"
    t.index ["promotion_code_id"], name: "index_order_promotions_on_promotion_code_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "state", default: "OPEN", null: false
    t.float "total"
    t.integer "discount_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_code_id"], name: "index_orders_on_discount_code_id"
    t.index ["uuid"], name: "index_orders_on_uuid", unique: true
  end

  create_table "pizzas", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pizzas_on_name", unique: true
  end

  create_table "promotion_codes", force: :cascade do |t|
    t.string "code", null: false
    t.integer "target_pizza_id", null: false
    t.string "target_size", null: false
    t.integer "from_quantity", null: false
    t.integer "to_quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_promotion_codes_on_code", unique: true
    t.index ["target_pizza_id"], name: "index_promotion_codes_on_target_pizza_id"
  end

  add_foreign_key "item_ingredients", "ingredients"
  add_foreign_key "item_ingredients", "order_items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "pizzas"
  add_foreign_key "order_promotions", "orders"
  add_foreign_key "order_promotions", "promotion_codes"
  add_foreign_key "orders", "discount_codes"
  add_foreign_key "promotion_codes", "pizzas", column: "target_pizza_id"
end
