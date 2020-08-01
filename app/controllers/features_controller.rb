class FeaturesController < ApplicationController
  def index
    render json: params[:product_id].present? ? features_by_product : Feature.all
  end

  def show
    render json: params[:product_id].present? ?  feature_by_product : Feature.find(params[:id])
  end

  private

  def features_by_product
    Feature.where(product_id: params[:product_id])
  end

  def feature_by_product
    Feature.where(product_id: params[:product_id], id: params[:id])
  end
end
