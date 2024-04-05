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

ActiveRecord::Schema[7.0].define(version: 2024_04_05_012525) do
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
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", default: ""
    t.string "email", default: "", null: false
    t.boolean "active", default: true
    t.bigint "lead_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lead_id"], name: "index_contacts_on_lead_id"
  end

  create_table "generated_emails", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "subject", default: "", null: false
    t.string "message_id", default: "", null: false
    t.bigint "contact_id", null: false
    t.bigint "business_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_generated_emails_on_business_id"
    t.index ["contact_id"], name: "index_generated_emails_on_contact_id"
  end

  create_table "leads", force: :cascade do |t|
    t.integer "count", default: 0
    t.integer "followup_count", default: 0
    t.datetime "first_followup", null: false
    t.datetime "second_followup", null: false
    t.datetime "third_followup", null: false
    t.datetime "fourth_followup", null: false
    t.bigint "business_id", null: false
    t.bigint "business_email_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_email_id"], name: "index_leads_on_business_email_id"
    t.index ["business_id"], name: "index_leads_on_business_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
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
  add_foreign_key "contacts", "leads"
  add_foreign_key "generated_emails", "businesses"
  add_foreign_key "generated_emails", "contacts"
  add_foreign_key "leads", "business_emails"
  add_foreign_key "leads", "businesses"
end
