class RolesController < ApplicationController
  def index
    roles = params[:product_id].present? && params[:client_id].present? ? roles_by_product_and_client : Role.all
    render json: roles
  end

  def show
    role = params[:product_id].present? && params[:client_id].present? ? role_by_product_and_client : Role.find(params[:id])
    return record_not_found unless role
    render json: params[:show_users] == 'true' ? role.to_json(include: :users) : role
  end

  def create
    render json: Role.create!(create_params), status: 201
  end

  def destroy
    role = params[:product_id].present? && params[:client_id].present? ? role_by_product_and_client : Role.find(params[:id])

    ApplicationRecord.transaction do
      UsersRole.destroy_by(roles_id: role.id)
      FeaturesRole.destroy_by(roles_id: role.id)
      role.destroy
    end

    render status: 204
  end

  private

  def create_params
    fields = params.require(:role).permit(:name, :product_id, :client_id)
    contract = Contract.where(product_id: fields[:product_id], client_id: fields[:client_id]).first
    { name: fields[:name], contract_id: contract.id }
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
