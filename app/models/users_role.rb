class UsersRole < ApplicationRecord
  belongs_to :users
  belongs_to :roles

  validates :users_id, presence: true, uniqueness: { scope: :roles_id }
  validates :roles_id, presence: true, uniqueness: { scope: :users_id }
end
