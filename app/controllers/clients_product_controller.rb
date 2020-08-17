class ClientsProductController < ApplicationController
  def create
    render json: ClientsProduct.create!(create_params), status: 201
  end

  private

  def create_params
    params.permit(:product_id, :client_id)
  end
end
