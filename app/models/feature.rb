class Feature < ApplicationRecord
  belongs_to :product

  validates :name, presence: true, uniqueness: { scope: :product_id }, length: { maximum: 30 }
  validates :product_id, presence: true, uniqueness: { scope: :name }
end
