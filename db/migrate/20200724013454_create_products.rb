class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, limit: 30, null: false
      t.string :description, limit: 300, null: false

      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
