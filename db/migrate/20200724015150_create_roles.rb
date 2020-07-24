class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.references :organizations_products, null: false, foreign_key: true
      t.string :name, limit: 30

      t.timestamps
    end
    add_index :roles, [:organizations_products_id, :name], unique: true
  end
end
