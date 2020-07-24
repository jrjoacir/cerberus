class CreateFeaturesRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :features_roles do |t|
      t.references :features, null: false, foreign_key: true
      t.references :roles, null: false, foreign_key: true

      t.timestamps
    end
    add_index :features_roles, [:features_id, :roles_id], unique: true
  end
end
