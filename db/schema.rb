# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_13_124839) do
  create_table "reservations", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.date "date"
    t.string "time_slot"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "adults"
    t.integer "children"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "user_active_session_keys", primary_key: ["user_id", "session_id"], charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "session_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP(6)" }, null: false
    t.datetime "last_use", default: -> { "CURRENT_TIMESTAMP(6)" }, null: false
    t.index ["user_id"], name: "index_user_active_session_keys_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.string "email", null: false
    t.string "password_hash"
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "user_active_session_keys", "users"
end
