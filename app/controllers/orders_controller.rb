class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.all
  end

  def soft_delete_index
    @orders = current_user.orders.only_deleted.page(params[:page]).per(5)
  end

  def recover
    @order = current_user.orders.with_deleted.find(params[:id])
    @order.recover
    redirect_to @order, notice: "Order recoverd."
  end 
  
  def show
    @order = current_user.orders.with_deleted.find(params[:id])
    @order_items = @order.order_items.with_deleted
  end

  def new
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.create!(status: :pending)
    redirect_to @order, notice: "Order created successfully."
  end

  def add_item
    @order = current_user.orders.find(params[:id])
    @order.add_product(params[:product_id])
    redirect_to @order, notice: "Product added to order."
  end

  def remove_item
    @order = current_user.orders.find(params[:id])
    @order_item = @order.order_items.find(params[:order_item_id])
    @order_item.destroy
    redirect_to @order, notice: "Order item removed."
  end

  def place_order
    @order = current_user.orders.find_by(id: params[:id])

    if @order.status == "pending"
      @order.update(status: "completed")
      redirect_to @order, notice: "order placed successfully."
    else
      redirect_to orders_path, alert: "Unable to place the order."
    end
  end

  def destroy
    @order = current_user.orders.with_deleted.find(params[:id])
    @order.destroy

    redirect_to orders_path, status: :see_other
  end
end

