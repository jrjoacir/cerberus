class FeaturesController < ApplicationController
  def index
    render json: params[:product_id].present? ? features_by_product : Feature.all
  end

  def show
    feature = params[:product_id].present? ? feature_by_product : Feature.find(params[:id])
    return record_not_found unless feature
    render json: feature
  end

  def create
    render json: Feature.create!(create_params), status: 201
  end

  private

  def create_params
    params.require(:feature).permit(:product_id, :name).merge(params.permit(:product_id))
  end

  def features_by_product
    Feature.where(product_id: params[:product_id])
  end

  def feature_by_product
    Feature.where(product_id: params[:product_id], id: params[:id]).first
  end
end
