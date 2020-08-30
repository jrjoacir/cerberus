class ClientsController < ApplicationController
  def index
    render json: params[:product_id].present? ? clients_by_product : Client.all
  end

  def show
    client = params[:product_id].present? ? client_by_product : Client.find(params[:id])
    render json: params[:show_products] == 'true' ? client.to_json(include: :products) : client
  end

  def create
    render json: Client.create!(valid_params), status: 201
  end

  def update
    client = Client.find(params[:id])
    client.update!(valid_params)
    render json: client, status: 200
  end

  private

  def valid_params
    params.require(:client).permit(:name)
  end

  def clients_by_product
    Contract.where(product_id: params[:product_id]).map(&:client)
  end

  def client_by_product
    Contract.where(client_id: params[:id], product_id: params[:product_id]).first!.client
  end
end
