class Feature < ApplicationRecord
  belongs_to :product
  has_many :features_roles, primary_key: :id, foreign_key: :features_id
  has_many :roles, through: :features_roles

  validates :name, presence: true, uniqueness: { scope: :product_id }, length: { maximum: 30 }
  validates :product_id, presence: true, uniqueness: { scope: :name }  
end
