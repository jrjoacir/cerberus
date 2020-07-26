class UsersRole < ApplicationRecord
  belongs_to :users, class_name: 'User'
  belongs_to :roles, class_name: 'Role'

  validates :users_id, presence: true, uniqueness: { scope: :roles_id }
  validates :roles_id, presence: true, uniqueness: { scope: :users_id }
end
