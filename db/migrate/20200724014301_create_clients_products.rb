class CreateClientsProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :clients_products do |t|
      t.references :client, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
    add_index :clients_products, [:client_id, :product_id], unique: true
  end
end
