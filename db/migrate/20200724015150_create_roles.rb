class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.references :contract, null: false, foreign_key: true
      t.string :name, limit: 30, null: false
      t.boolean :enabled, :default => false, null: false

      t.timestamps
    end
    add_index :roles, [:contract_id, :name], unique: true
  end
end
