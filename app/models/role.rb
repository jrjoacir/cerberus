class Role < ApplicationRecord
  belongs_to :organizations_products

  validates :name, presence: true, uniqueness: { scope: :organizations_products_id }, length: { maximum: 30 }
  validates :organizations_products_id, presence: true, uniqueness: { scope: :name }
end
