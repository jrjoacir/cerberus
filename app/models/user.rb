class User < ApplicationRecord
  validates :login, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :name, presence: true, length: { maximum: 60 }
end
