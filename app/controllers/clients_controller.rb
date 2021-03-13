class ClientsController < ApplicationController
  def index
    render_paginate(find_clients)
  end

  def show
    client = find_clients.first!
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

  def find_clients
    return Client.where(filter_params) if params[:product_id].blank?

    Client.where(filter_params).joins(:contract).where(contracts: { product_id: params[:product_id] })
  end

  def filter_params
    { name: params[:name], id: params[:id] }.compact
  end
end
