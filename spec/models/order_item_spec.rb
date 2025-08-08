require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "associations" do
    it { should belong_to(:order) }
    it { should belong_to(:pizza) }
    it { should have_many(:item_ingredients).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:size) }
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe "#calculate_price" do
    let(:pizza) { create(:pizza, price: 6.0) }
    let(:ingredient) { create(:ingredient, price: 2.0) }
    let(:order_item) { create(:order_item, pizza: pizza, size: "Large") }

    context "with added ingredients" do
      before do
        create(:item_ingredient, order_item: order_item, ingredient: ingredient, added: true)
      end

      it "calculates the correct price" do
        expect(order_item.calculate_price).to eq(10.4)
      end
    end

    context "without added ingredients" do
      it "returns only the base price" do
        expect(order_item.calculate_price).to eq(7.8)
      end
    end
  end
end
