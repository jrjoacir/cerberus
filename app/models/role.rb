class Role < ApplicationRecord
  belongs_to :clients_products, class_name: "ClientsProduct"
  has_many :features_roles, primary_key: :id, foreign_key: :roles_id
  has_many :features, through: :features_roles
  has_many :users_roles, primary_key: :id, foreign_key: :roles_id
  has_many :users, through: :users_roles

  validates :name, presence: true, uniqueness: { scope: :clients_products_id }, length: { maximum: 30 }
  validates :clients_products_id, presence: true, uniqueness: { scope: :name }
end
