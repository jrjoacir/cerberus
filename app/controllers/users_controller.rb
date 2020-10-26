class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    render json: params[:show_details] == 'true' ? user.to_hash.merge(details: user.details_hash) : user
  end

  def create
    render json: User.create!(valid_params), status: 201
  end

  def destroy
    user = User.find(params[:id])

    ApplicationRecord.transaction do
      UsersRole.destroy_by(user_id: user.id)
      user.destroy
    end

    render status: 204
  end

  def update
    user = User.find(params[:id])
    user.update!(valid_params)
    render json: user, status: 200
  end

  private

  def valid_params
    params.require(:user).permit(:login, :name)
  end
end
