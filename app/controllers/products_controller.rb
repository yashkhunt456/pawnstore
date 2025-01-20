class ProductsController < ApplicationController
  before_action :find_product, only: %i[show edit update destroy]
  before_action :admin_access, only: %i[new create edit update destroy]

  def index
    @products = Product.all
  end

  def show

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)

    if @product.save 
      redirect_to @product, notice: "product created."
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "product created."
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def admin_access
    unless current_user.has_role?(:admin)
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
 