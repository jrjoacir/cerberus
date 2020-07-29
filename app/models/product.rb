class Product < ApplicationRecord
  has_many :features
  has_many :clients_products
  has_many :clients, through: :clients_products

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 300 }
end
