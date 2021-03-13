class ProductsController < ApplicationController
  def index
    render_paginate(find_products)
  end

  def show
    product = find_products.first!
    render json: product.to_json(include_json)
  end

  def create
    render json: Product.create!(valid_params), status: 201
  end

  def update
    product = Product.find(params[:id])
    product.update!(valid_params)
    render json: product, status: 200
  end

  private

  def include_json
    includes = { include: [] }
    includes[:include] << :clients if params[:show_clients] == 'true'
    includes[:include] << :features if params[:show_features] == 'true'
    includes
  end

  def valid_params
    params.require(:product).permit(:name, :description)
  end

  def find_products
    return Product.where(filter_params) if params[:client_id].blank?

    Product.where(filter_params).joins(:contract).where(contracts: { client_id: params[:client_id] })
  end

  def filter_params
    { name: params[:name], id: params[:id] }.compact
  end
end
