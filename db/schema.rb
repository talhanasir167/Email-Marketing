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

ActiveRecord::Schema[7.0].define(version: 2024_04_28_104027) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_emails", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_emails_on_business_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "tag_line", default: "", null: false
    t.string "website_url", default: ""
    t.bigint "user_id", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "compaigns", force: :cascade do |t|
    t.integer "leads_count", default: 0
    t.datetime "scheduled_at", default: "2024-04-28 10:50:43", null: false
    t.bigint "business_id", null: false
    t.bigint "business_email_id", null: false
    t.bigint "service_id", null: false
    t.bigint "country_id", null: false
    t.bigint "title_id", null: false
    t.bigint "platform_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_email_id"], name: "index_compaigns_on_business_email_id"
    t.index ["business_id"], name: "index_compaigns_on_business_id"
    t.index ["country_id"], name: "index_compaigns_on_country_id"
    t.index ["platform_id"], name: "index_compaigns_on_platform_id"
    t.index ["service_id"], name: "index_compaigns_on_service_id"
    t.index ["title_id"], name: "index_compaigns_on_title_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_services_on_business_id"
  end

  create_table "titles", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "business_emails", "businesses"
  add_foreign_key "businesses", "users"
  add_foreign_key "compaigns", "business_emails"
  add_foreign_key "compaigns", "businesses"
  add_foreign_key "compaigns", "countries"
  add_foreign_key "compaigns", "platforms"
  add_foreign_key "compaigns", "services"
  add_foreign_key "compaigns", "titles"
  add_foreign_key "services", "businesses"
end
