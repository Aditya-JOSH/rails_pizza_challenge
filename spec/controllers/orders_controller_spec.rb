require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET #index" do
    before do
      create_list(:order, 3, state: "OPEN")
      create_list(:order, 2, state: "COMPLETED")
      get :index
    end

    it "returns a successful response" do
      expect(response).to be_successful
    end

    it "assigns only open orders to @orders" do
      expect(assigns(:orders).count).to eq(3)
      expect(assigns(:orders).map(&:state).uniq).to eq([ "open" ])
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end

  describe "PATCH #update" do
    let(:order) { create(:order, state: "OPEN") }

    context "with valid parameters" do
      before do
        patch :update, params: { id: order.uuid }
      end

      it "updates the order state" do
        order.reload
        expect(order.state).to eq("completed")
      end

      it "redirects to the orders index" do
        expect(response).to redirect_to(orders_path)
      end

      it "sets a notice message" do
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid parameters" do
      before do
        patch :update, params: { id: "invalid-uuid" }
      end

      it "redirects to the orders index" do
        expect(response).to redirect_to(orders_path)
      end

      it "sets an alert message" do
        expect(flash[:alert]).to be_present
      end
    end
  end
end
