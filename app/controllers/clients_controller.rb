class ClientsController < ApplicationController
  def index
    render json: params[:product_id].present? ? clients_by_product : Client.all
    #render json: Client.all
  end

  def show
    render json: Client.find(params[:id])
  end

  def create
    render json: Client.create!(create_params), status: 201
  end

  private

  def create_params
    params.require(:client).permit(:name)
  end

  def clients_by_product
    ClientsProduct.where(product_id: params[:product_id]).map(&:client)
  end
end
