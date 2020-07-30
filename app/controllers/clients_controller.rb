class ClientsController < ApplicationController
  def index
    render json: Client.all
  end

  def show
    render json: Client.find(params[:id])
  end

  def create
    render json: Client.create!(create_params), status: 201
  end

  private

  def create_params
    params.require(:client).permit(:name)
  end
end
