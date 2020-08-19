class ProductsController < ApplicationController
  def index
    render json: params[:client_id].present? ? products_by_client : Product.all
  end

  def show
    product = params[:client_id].present? ? product_by_client : Product.find(params[:id])
    render json: params[:show_clients] == 'true' ? product.to_json(include: :clients) : product
  end

  def create
    render json: Product.create!(create_params), status: 201
  end

  private

  def create_params
    params.require(:product).permit(:name, :description)
  end

  def products_by_client
    ClientsProduct.where(client_id: params[:client_id]).map(&:product)
  end

  def product_by_client
    ClientsProduct.where(client_id: params[:client_id], product_id: params[:id]).first!.product
  end
end
