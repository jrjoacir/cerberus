class CreateOrganizationsProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations_products do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
    add_index :organizations_products, [:organization_id, :product_id], unique: true
  end
end
