# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_24_015349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_clients_on_name", unique: true
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id", "product_id"], name: "index_contracts_on_client_id_and_product_id", unique: true
    t.index ["client_id"], name: "index_contracts_on_client_id"
    t.index ["product_id"], name: "index_contracts_on_product_id"
  end

  create_table "features", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name", limit: 30, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id", "name"], name: "index_features_on_product_id_and_name", unique: true
    t.index ["product_id"], name: "index_features_on_product_id"
  end

  create_table "features_roles", force: :cascade do |t|
    t.bigint "features_id", null: false
    t.bigint "roles_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["features_id", "roles_id"], name: "index_features_roles_on_features_id_and_roles_id", unique: true
    t.index ["features_id"], name: "index_features_roles_on_features_id"
    t.index ["roles_id"], name: "index_features_roles_on_roles_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.string "description", limit: 300, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.string "name", limit: 30, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contract_id", "name"], name: "index_roles_on_contract_id_and_name", unique: true
    t.index ["contract_id"], name: "index_roles_on_contract_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", limit: 30, null: false
    t.string "name", limit: 60, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "users_roles", force: :cascade do |t|
    t.bigint "users_id", null: false
    t.bigint "roles_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["roles_id"], name: "index_users_roles_on_roles_id"
    t.index ["users_id", "roles_id"], name: "index_users_roles_on_users_id_and_roles_id", unique: true
    t.index ["users_id"], name: "index_users_roles_on_users_id"
  end

  add_foreign_key "contracts", "clients"
  add_foreign_key "contracts", "products"
  add_foreign_key "features", "products"
  add_foreign_key "features_roles", "features", column: "features_id"
  add_foreign_key "features_roles", "roles", column: "roles_id"
  add_foreign_key "roles", "contracts"
  add_foreign_key "users_roles", "roles", column: "roles_id"
  add_foreign_key "users_roles", "users", column: "users_id"
end
