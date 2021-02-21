class FeaturesController < ApplicationController
  def index
    return render_paginate(features_by_product) if params[:product_id].present?

    return render_paginate(features_by_user_and_contract) if params[:user_id].present? && params[:contract_id].present?

    render_paginate(Feature)
  end

  def show
    feature = params[:product_id].present? ? feature_by_product : Feature.find(params[:id])
    return record_not_found unless feature

    render json: feature
  end

  def create
    render json: Feature.create!(valid_params), status: 201
  end

  def destroy
    feature = params[:product_id].present? ? feature_by_product : Feature.find(params[:id])

    ApplicationRecord.transaction do
      FeaturesRole.destroy_by(feature_id: feature.id)
      feature.destroy
    end

    render status: 204
  end

  def update
    feature = Feature.find(params[:id])
    feature.update!(valid_params)
    render json: feature, status: 200
  end

  private

  def valid_params
    params.require(:feature).permit(:product_id, :name, :enabled, :read_only).merge(params.permit(:product_id))
  end

  def features_by_product
    Feature.where(product_id: params[:product_id])
  end

  def feature_by_product
    Feature.where(product_id: params[:product_id], id: params[:id]).first
  end

  def features_by_user_and_contract
    Feature.joins(features_roles: { role: %i[users_roles contract] })
           .where(users_roles: { user_id: params[:user_id] }, contracts: { id: params[:contract_id] })
  end
end
