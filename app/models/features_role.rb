class FeaturesRole < ApplicationRecord
  belongs_to :feature
  belongs_to :role

  validates :feature_id, presence: true, uniqueness: { scope: :role_id }
  validates :role_id, presence: true, uniqueness: { scope: :feature_id }
end
