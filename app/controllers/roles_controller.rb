class RolesController < ApplicationController
  def index
    roles = params[:product_id].present? && params[:client_id].present? ? roles_by_product_and_client : Role
    render_paginate(roles)
  end

  def show
    id = params[:id]
    role = params[:product_id].present? && params[:client_id].present? ? role_by_product_and_client : Role.find(id)
    return record_not_found unless role

    render json: params[:show_users] == 'true' ? role.to_json(include: :users) : role
  end

  def create
    render json: Role.create!(valid_params), status: 201
  end

  def destroy
    id = params[:id]
    role = params[:product_id].present? && params[:client_id].present? ? role_by_product_and_client : Role.find(id)
    role.destroy
    render status: 204
  end

  def update
    role = Role.find(params[:id])
    role.update!(valid_params)
    render json: role, status: 200
  end

  private

  def valid_params
    params.require(:role).permit(:name, :contract_id, :enabled)
  end

  def roles_by_product_and_client
    contract = Contract.where(product_id: params[:product_id], client_id: params[:client_id]).first
    contract&.roles || []
  end

  def role_by_product_and_client
    role = Role.find(params[:id])
    contract = role.contract
    role if contract.product_id == params[:product_id].to_i && contract.client_id == params[:client_id].to_i
  end
end
