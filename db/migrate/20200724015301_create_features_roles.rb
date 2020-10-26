class CreateFeaturesRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :features_roles do |t|
      t.references :feature, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
    add_index :features_roles, %i[feature_id role_id], unique: true
  end
end
