class OrganizationsProduct < ApplicationRecord
  belongs_to :organization
  belongs_to :product

  validates :product_id, presence: true, uniqueness: { scope: :organization_id }
  validates :organization_id, presence: true, uniqueness: { scope: :product_id }
end
