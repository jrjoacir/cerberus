class CreateFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :features do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name, limit: 30, null: false
      t.boolean :enabled, default: false, null: false
      t.boolean :read_only, default: false, null: true

      t.timestamps
    end
    add_index :features, %i[product_id name], unique: true
  end
end
