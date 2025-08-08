require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "associations" do
    it { should have_many(:order_items).dependent(:destroy) }
    it { should have_many(:order_promotions).dependent(:destroy) }
    it { should have_many(:promotion_codes).through(:order_promotions) }
    it { should belong_to(:discount_code).optional }
  end

  describe "enums" do
    it "defines state as a string enum with correct values" do
      expect(Order.states).to eq({ "open" => "OPEN", "completed" => "COMPLETED" })
    end
  end

  describe "#calculate_total" do
    let(:pizza) { create(:pizza, price: 6.0) }
    let(:ingredient) { create(:ingredient, price: 2.0) }
    let(:discount) { create(:discount_code, percentage: 10) }
    let(:order) { create(:order, discount_code: discount) }

    before do
      order_item = create(:order_item, order: order, pizza: pizza, size: "Medium", quantity: 2)
      create(:item_ingredient, order_item: order_item, ingredient: ingredient, added: true)
    end

    it "calculates the correct total" do
      expect(order.calculate_total).to eq(14.4)
      expect(order.total).to eq(14.4)
    end
  end

  describe "#apply_promotions" do
    let(:pizza) { create(:pizza, price: 6.0) }
    let(:promotion) { create(:promotion_code, target_pizza: pizza, target_size: "Small", from_quantity: 2, to_quantity: 1) }
    let(:order) { create(:order) }

    before do
      create(:order_promotion, order: order, promotion_code: promotion)
    end

    context "when promotion applies" do
      before do
        create(:order_item, order: order, pizza: pizza, size: "Small", quantity: 2)
      end

      it "calculates the correct discount" do
        expect(order.apply_promotions).to eq(4.2)
      end
    end

    context "when promotion does not apply" do
      before do
        create(:order_item, order: order, pizza: pizza, size: "Medium", quantity: 2)
      end

      it "returns zero discount" do
        expect(order.apply_promotions).to eq(0)
      end
    end
  end

  describe "#mark_as_completed" do
    let(:order) { create(:order, state: "OPEN") }

    it "changes the state to completed" do
      order.mark_as_completed
      expect(order.state).to eq("completed")
    end
  end
end
