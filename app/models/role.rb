class Role < ApplicationRecord
  belongs_to :organizations_products, class_name: "OrganizationsProduct"

  validates :name, presence: true, uniqueness: { scope: :organizations_products_id }, length: { maximum: 30 }
  validates :organizations_products_id, presence: true, uniqueness: { scope: :name }
end
