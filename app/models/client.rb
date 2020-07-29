class Client < ApplicationRecord
  has_many :clients_products
  has_many :products, through: :clients_products

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
end
