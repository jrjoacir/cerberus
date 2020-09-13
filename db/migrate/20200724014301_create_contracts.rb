class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.references :client, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.boolean :enabled, default: false, null: false

      t.timestamps
    end
    add_index :contracts, %i[client_id product_id], unique: true
  end
end
