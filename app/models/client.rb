class Client < ApplicationRecord
  has_many :contract
  has_many :products, through: :contract

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
end
