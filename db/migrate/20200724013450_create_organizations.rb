class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name, limit: 30, null: false

      t.timestamps
    end
    add_index :organizations, :name, unique: true
  end
end
