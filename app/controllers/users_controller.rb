class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show  
    user = User.find(params[:id])
    render json: params[:show_details] == 'true' ? user.to_hash.merge(details: user.details_hash) : user
  end

  def create
    render json: User.create!(create_params), status: 201
  end

  private

  def create_params
    params.require(:user).permit(:login, :name)
  end
end
