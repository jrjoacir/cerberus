class User < ApplicationRecord
  has_many :users_roles, primary_key: :id, foreign_key: :user_id
  has_many :roles, through: :users_roles

  validates :login, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :name, presence: true, length: { maximum: 60 }

  def to_hash
    JSON.parse(to_json).deep_symbolize_keys
  end

  def details_hash
    @details_hash ||= { roles: roles_hash }
  end

  private

  def roles_hash
    @roles_hash ||= roles.map do |role|
      { id: role.id, name: role.name, product: product_by(role), client: client_by(role) }
    end
  end

  def client_by(model)
    { id: model.client.id, name: model.client.name }
  end

  def product_by(model)
    { id: model.product.id, name: model.product.name, features: features_by(model) }
  end

  def features_by(model)
    model.features.map { |feature| { id: feature.id, name: feature.name } }
  end
end
