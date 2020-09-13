class Role < ApplicationRecord
  belongs_to :contract
  has_many :features_roles, primary_key: :id, foreign_key: :roles_id, dependent: :destroy
  has_many :features, through: :features_roles
  has_many :users_roles, primary_key: :id, foreign_key: :roles_id, dependent: :destroy
  has_many :users, through: :users_roles

  validates :name, presence: true, uniqueness: { scope: :contract_id }, length: { maximum: 30 }
  validates :contract_id, presence: true, uniqueness: { scope: :name }

  def product
    @product ||= contract.product
  end

  def client
    @client ||= contract.client
  end
end
