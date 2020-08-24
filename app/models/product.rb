class Product < ApplicationRecord
  has_many :features
  has_many :contract
  has_many :clients, through: :contract

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 300 }
end
