class OrdersController < ApplicationController
  def index
    @orders = Order.open
      .includes(:discount_code,
              :promotion_codes,
              order_items: [ :pizza, { item_ingredients: :ingredient } ])
      .page(params[:page])
      .per(10)
  rescue => e
    Rails.logger.error("Error fetching orders: #{e.message}")

    @orders = Order.none.page(1)
    flash.now[:alert] = "There was a problem loading the orders. Please try again."
  end

  def update
    @order = Order.find_by(uuid: params[:id])

    if @order.nil?
      respond_to do |format|
        format.html {
          redirect_to orders_path,
          alert: "Order not found with ID: #{params[:id]}"
        }
        format.json { render json: { error: "Order not found" }, status: :not_found }
      end
      return
    end

    begin
      result = @order.mark_as_completed
      if result
        respond_to do |format|
          format.html { redirect_to orders_path, notice: "Order was successfully completed." }
          format.json { head :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to orders_path, alert: "Could not complete order." }
          format.json { render json: { error: "Could not complete order" }, status: :unprocessable_entity }
        end
      end
    rescue => e
      Rails.logger.error("Error completing order #{@order.uuid}: #{e.message}")

      respond_to do |format|
        format.html {
          redirect_to orders_path,
          alert: "An unexpected error occurred while processing your request."
        }
        format.json { render json: { error: e.message }, status: :internal_server_error }
      end
    end
  end
end
