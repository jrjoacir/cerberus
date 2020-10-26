class FeaturesRoleController < ApplicationController
  def create
    render json: FeaturesRole.create!(valid_params), status: 201
  end

  def destroy
    FeaturesRole.destroy_by(valid_params)
    render status: 204
  end

  private

  def valid_params
    params.permit(:feature_id, :role_id)
  end
end
