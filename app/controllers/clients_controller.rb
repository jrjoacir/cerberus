class ClientsController < ApplicationController
  def index
    render json: params[:product_id].present? ? clients_by_product : Client.all
  end

  def show
    client = params[:product_id].present? ? client_by_product : Client.find(params[:id])
    render json: params[:show_products] == 'true' ? client.to_json(include: :products) : client
  end

  def create
    render json: Client.create!(create_params), status: 201
  end

  private

  def create_params
    params.require(:client).permit(:name)
  end

  def clients_by_product
    Contract.where(product_id: params[:product_id]).map(&:client)
  end

  def client_by_product
    Contract.where(client_id: params[:id], product_id: params[:product_id]).first!.client
  end
end
