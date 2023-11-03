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

ActiveRecord::Schema[7.0].define(version: 2023_11_03_115450) do
  create_table "account_login_change_keys", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "key", null: false
    t.string "login", null: false
    t.datetime "deadline", null: false
  end

  create_table "account_otp_keys", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "key", null: false
    t.integer "num_failures", default: 0, null: false
    t.datetime "last_use", default: -> { "CURRENT_TIMESTAMP(6)" }, null: false
  end

  create_table "account_password_reset_keys", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP(6)" }, null: false
  end

  create_table "account_recovery_codes", primary_key: ["id", "code"], charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.bigint "id", null: false
    t.string "code", null: false
  end

  create_table "account_remember_keys", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
  end

  create_table "account_sms_codes", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "phone_number", null: false
    t.integer "num_failures"
    t.string "code"
    t.datetime "code_issued_at", default: -> { "CURRENT_TIMESTAMP(6)" }, null: false
  end

  create_table "account_verification_keys", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "requested_at", default: -> { "CURRENT_TIMESTAMP(6)" }, null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP(6)" }, null: false
  end

  create_table "accounts", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.string "email", null: false
    t.string "password_hash"
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

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

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "phone_number"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "account_login_change_keys", "accounts", column: "id"
  add_foreign_key "account_otp_keys", "accounts", column: "id"
  add_foreign_key "account_password_reset_keys", "accounts", column: "id"
  add_foreign_key "account_recovery_codes", "accounts", column: "id"
  add_foreign_key "account_remember_keys", "accounts", column: "id"
  add_foreign_key "account_sms_codes", "accounts", column: "id"
  add_foreign_key "account_verification_keys", "accounts", column: "id"
  add_foreign_key "reservations", "users"
end
