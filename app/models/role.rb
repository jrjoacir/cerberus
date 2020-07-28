class Role < ApplicationRecord
  belongs_to :clients_products, class_name: "ClientsProduct"

  validates :name, presence: true, uniqueness: { scope: :clients_products_id }, length: { maximum: 30 }
  validates :clients_products_id, presence: true, uniqueness: { scope: :name }
end
