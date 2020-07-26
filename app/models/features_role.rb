class FeaturesRole < ApplicationRecord
  belongs_to :features
  belongs_to :roles

  validates :features_id, presence: true, uniqueness: { scope: :roles_id }
  validates :roles_id, presence: true, uniqueness: { scope: :features_id }
end
