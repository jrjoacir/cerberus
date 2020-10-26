class UsersRoleController < ApplicationController
  def create
    render json: UsersRole.create!(valid_params), status: 201
  end

  def destroy
    UsersRole.destroy_by(valid_params)
    render status: 204
  end

  private

  def valid_params
    params.permit(:user_id, :role_id)
  end
end
