class OrganizationsUser < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :organization_id }
  validates :organization_id, presence: true, uniqueness: { scope: :user_id }
end
