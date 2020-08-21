class FeaturesRoleController < ApplicationController
  def create
    render json: FeaturesRole.create!(create_params), status: 201
  end

  private

  def create_params
    params.permit(:feature_id, :role_id)
    { features_id: params[:feature_id], roles_id: params[:role_id] }
  end
end
