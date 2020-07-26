class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 300 }
end
