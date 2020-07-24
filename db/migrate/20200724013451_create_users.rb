class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :login, limit: 30, null: false
      t.string :name, limit: 60, null: false

      t.timestamps
    end
    add_index :users, :login, unique: true
  end
end
