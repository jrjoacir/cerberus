class Contract < ApplicationRecord
  belongs_to :client
  belongs_to :product
  has_many :roles

  validates :product_id, presence: true, uniqueness: { scope: :client_id }
  validates :client_id, presence: true, uniqueness: { scope: :product_id }  
end
