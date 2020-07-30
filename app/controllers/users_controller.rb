class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    render json: User.create!(create_params), status: 201
  end

  private

  def create_params
    params.require(:user).permit(:login, :name)
  end
end
