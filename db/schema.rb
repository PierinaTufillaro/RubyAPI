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

ActiveRecord::Schema.define(version: 2020_01_31_113735) do

  create_table "clients", force: :cascade do |t|
    t.string "cuit_cuil", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.integer "iva_cond", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "status", null: false
    t.integer "product_id"
    t.integer "reservation_id"
    t.integer "sell_id"
    t.decimal "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["reservation_id"], name: "index_items_on_reservation_id"
    t.index ["sell_id"], name: "index_items_on_sell_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "number"
    t.integer "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_phones_on_client_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "code", null: false
    t.string "short_description", null: false
    t.string "long_description", null: false
    t.decimal "unit_amount", null: false
    t.integer "stock"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.boolean "sold", default: false
    t.decimal "total_amount"
    t.integer "user_id"
    t.integer "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "sells", force: :cascade do |t|
    t.decimal "total_amount"
    t.integer "user_id"
    t.integer "client_id"
    t.integer "reservation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_sells_on_client_id"
    t.index ["reservation_id"], name: "index_sells_on_reservation_id"
    t.index ["user_id"], name: "index_sells_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "token_created_at"
    t.string "authentication_token", default: "blank"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
