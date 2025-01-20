class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order

  def edit
    @order_item = @order.order_items.find(params[:id])
  end

  def update
    @order_item = @order.order_items.find(params[:id])

    if @order_item.update(order_item_params)
      redirect_to @order, notice: "Order item updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:order_id])
  end

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end
end

