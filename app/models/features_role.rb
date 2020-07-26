class FeaturesRole < ApplicationRecord
  belongs_to :features, class_name: 'Feature'
  belongs_to :roles, class_name: 'Role'

  validates :features_id, presence: true, uniqueness: { scope: :roles_id }
  validates :roles_id, presence: true, uniqueness: { scope: :features_id }
end
