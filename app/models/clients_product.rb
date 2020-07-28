class ClientsProduct < ApplicationRecord
  belongs_to :client
  belongs_to :product

  validates :product_id, presence: true, uniqueness: { scope: :client_id }
  validates :client_id, presence: true, uniqueness: { scope: :product_id }
end
