class ProductsController < ApplicationController
  def index
    render json: params[:client_id].present? ? products_by_client : Product.all
  end

  def show
    product = params[:client_id].present? ? product_by_client : Product.find(params[:id])
    render json: product.to_json(include_json)
  end

  def create
    render json: Product.create!(create_params), status: 201
  end

  private

  def include_json
    includes = { include: [] }
    includes[:include] << :clients if params[:show_clients] == 'true'
    includes[:include] << :features if params[:show_features] == 'true'
    includes
  end

  def create_params
    params.require(:product).permit(:name, :description)
  end

  def products_by_client
    Contract.where(client_id: params[:client_id]).map(&:product)
  end

  def product_by_client
    Contract.where(client_id: params[:client_id], product_id: params[:id]).first!.product
  end
end
