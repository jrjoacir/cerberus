class User < ApplicationRecord
  has_many :users_roles, primary_key: :id, foreign_key: :users_id
  has_many :roles, through: :users_roles

  validates :login, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :name, presence: true, length: { maximum: 60 }
end
