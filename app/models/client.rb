class Client < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
end
