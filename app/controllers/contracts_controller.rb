class ContractsController < ApplicationController
  def create
    render json: Contract.create!(create_params), status: 201
  end

  def index
    contracts = params[:user_id].present? ? contracts_by_user : Contract.all
    render json: contracts.to_json(include_json)
  end

  private

  def include_json
    includes = { include: [] }
    includes[:include] << :product if params[:show_product_details] == 'true'
    includes[:include] << :client if params[:show_client_details] == 'true'
    includes
  end

  def create_params
    params.permit(:product_id, :client_id, :enabled)
  end

  def contracts_by_user
    User.find(params[:user_id]).roles.map(&:contract)
  end
end
