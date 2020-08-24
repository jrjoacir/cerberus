class User < ApplicationRecord
  has_many :users_roles, primary_key: :id, foreign_key: :users_id
  has_many :roles, through: :users_roles

  validates :login, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :name, presence: true, length: { maximum: 60 }

  def to_hash
    JSON.parse(self.to_json).deep_symbolize_keys
  end

  def details_hash
    @details_hash ||= { roles: roles_hash }
  end

  private

  def roles_hash
    @roles_hash ||= self.roles.map do |role|
      features = role.features.map {|feature| {id: feature.id, name: feature.name }}
      client = { id: role.client.id, name: role.client.name }
      product = { id: role.product.id, name: role.product.name, features: features }
      { id: role.id, name: role.name, product: product, client: client }
    end
  end
end
