require 'yaml'

config = YAML.load_file(Rails.root.join('data', 'config.yml'))

config['pizzas'].each do |name, price|
  Pizza.create!(name: name, price: price)
end

config['ingredients'].each do |name, price|
  Ingredient.create!(name: name, price: price)
end

config['discounts'].each do |code, details|
  DiscountCode.create!(code: code, percentage: details['deduction_in_percent'])
end

config['promotions'].each do |code, details|
  pizza = Pizza.find_by(name: details['target'])
  PromotionCode.create!(
    code: code,
    target_pizza: pizza,
    target_size: details['target_size'],
    from_quantity: details['from'],
    to_quantity: details['to']
  )
end

json_data = JSON.parse(File.read(Rails.root.join('data', 'orders.json')))

json_data.each do |order_data|
  order = Order.create!(
    uuid: order_data['id'],
    state: order_data['state'],
    created_at: order_data['createdAt'],
    discount_code: DiscountCode.find_by(code: order_data['discountCode'])
  )

  order_data['items'].each do |item_data|
    pizza = Pizza.find_by(name: item_data['name'])
    order_item = OrderItem.create!(
      order: order,
      pizza: pizza,
      size: item_data['size'],
      quantity: 1
    )

    item_data['add'].each do |ingredient_name|
      ingredient = Ingredient.find_by(name: ingredient_name)
      ItemIngredient.create!(
        order_item: order_item,
        ingredient: ingredient,
        added: true
      )
    end

    item_data['remove'].each do |ingredient_name|
      ingredient = Ingredient.find_by(name: ingredient_name)
      ItemIngredient.create!(
        order_item: order_item,
        ingredient: ingredient,
        added: false
      )
    end
  end

  order_data['promotionCodes'].each do |promo_code|
    promotion = PromotionCode.find_by(code: promo_code)
    OrderPromotion.create!(
      order: order,
      promotion_code: promotion
    )
  end

  order.calculate_total
end
