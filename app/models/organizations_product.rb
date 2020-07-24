class OrganizationsProduct < ApplicationRecord
  belongs_to :organization
  belongs_to :product
end
