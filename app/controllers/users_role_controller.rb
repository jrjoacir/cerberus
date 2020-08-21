class UsersRoleController < ApplicationController
  def create
    render json: UsersRole.create!(create_params), status: 201
  end

  private

  def create_params
    params.permit(:user_id, :role_id)
    { users_id: params[:user_id], roles_id: params[:role_id] }
  end
end
