class RolesController < ApplicationController
  def index
    roles = params[:product_id].present? && params[:client_id].present? ? roles_by_product_and_client : Role.all
    render json: roles
  end

  def show
    role = params[:product_id].present? && params[:client_id].present? ? role_by_product_and_client : Role.find(params[:id])
    return record_not_found unless role
    render json: role
  end

  def create
    render json: Role.create!(create_params), status: 201
  end

  private

  def create_params
    fields = params.require(:role).permit(:name, :product_id, :client_id)
    client_product = ClientsProduct.where(product_id: fields[:product_id], client_id: fields[:client_id]).first
    { name: fields[:name], clients_products_id: client_product.id }
  end

  def roles_by_product_and_client
    client_product = ClientsProduct.where(product_id: params[:product_id], client_id: params[:client_id]).first
    client_product&.roles || []
  end

  def role_by_product_and_client
    role = Role.find(params[:id])
    client_product = role.clients_products
    role if client_product.product_id == params[:product_id].to_i && client_product.client_id == params[:client_id].to_i
  end
end
