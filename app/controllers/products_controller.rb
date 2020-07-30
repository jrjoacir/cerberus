class ProductsController < ApplicationController
  def index
    render json: Product.all
  end

  def show
    render json: Product.find(params[:id])
  end

  def create
    render json: Product.create!(create_params), status: 201
  end

  private

  def create_params
    params.require(:product).permit(:name, :description)
  end
end
