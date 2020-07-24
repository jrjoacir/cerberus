class CreateUsersRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :users_roles do |t|
      t.references :users, null: false, foreign_key: true
      t.references :roles, null: false, foreign_key: true

      t.timestamps
    end
    add_index :users_roles, [:users_id, :roles_id], unique: true
  end
end
