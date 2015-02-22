# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150222022616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "subdomain"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounts", ["owner_id"], name: "index_accounts_on_owner_id", using: :btree

  create_table "lead_certifications", force: :cascade do |t|
    t.string  "name",       null: false
    t.string  "authority"
    t.string  "license"
    t.string  "start_date"
    t.integer "lead_id"
  end

  add_index "lead_certifications", ["lead_id"], name: "index_lead_certifications_on_lead_id", using: :btree

  create_table "lead_companies", force: :cascade do |t|
    t.string  "company"
    t.string  "title",                null: false
    t.string  "company_url"
    t.text    "description"
    t.string  "linkedin_company_url"
    t.string  "url"
    t.string  "company_size"
    t.string  "website"
    t.string  "industry"
    t.string  "founded"
    t.string  "type"
    t.text    "address"
    t.text    "headquarters"
    t.integer "lead_id"
    t.date    "start_date"
    t.date    "end_date"
    t.string  "company_type"
    t.date    "created_on"
    t.date    "updated_on"
  end

  add_index "lead_companies", ["lead_id"], name: "index_lead_companies_on_lead_id", using: :btree

  create_table "lead_educations", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.string  "period"
    t.integer "lead_id"
  end

  add_index "lead_educations", ["lead_id"], name: "index_lead_educations_on_lead_id", using: :btree

  create_table "lead_groups", force: :cascade do |t|
    t.string  "name",    null: false
    t.string  "link",    null: false
    t.integer "lead_id"
  end

  add_index "lead_groups", ["lead_id"], name: "index_lead_groups_on_lead_id", using: :btree

  create_table "lead_languages", force: :cascade do |t|
    t.string  "language",    null: false
    t.string  "proficiency"
    t.integer "lead_id"
  end

  add_index "lead_languages", ["lead_id"], name: "index_lead_languages_on_lead_id", using: :btree

  create_table "lead_organisations", force: :cascade do |t|
    t.string  "name",       null: false
    t.date    "start_date"
    t.date    "end_date"
    t.integer "lead_id"
  end

  add_index "lead_organisations", ["lead_id"], name: "index_lead_organisations_on_lead_id", using: :btree

  create_table "lead_skills", force: :cascade do |t|
    t.string  "skill",   null: false
    t.integer "lead_id"
  end

  add_index "lead_skills", ["lead_id"], name: "index_lead_skills_on_lead_id", using: :btree

  create_table "lead_websites", force: :cascade do |t|
    t.string  "site",    null: false
    t.integer "lead_id"
  end

  add_index "lead_websites", ["lead_id"], name: "index_lead_websites_on_lead_id", using: :btree

  create_table "leads", force: :cascade do |t|
    t.string  "first_name",   null: false
    t.string  "last_name",    null: false
    t.string  "headline"
    t.string  "summary"
    t.string  "linkedin_url", null: false
    t.string  "photo_url"
    t.string  "location"
    t.string  "country"
    t.string  "industry"
    t.integer "query_id"
  end

  add_index "leads", ["query_id"], name: "index_leads_on_query_id", using: :btree

  create_table "queries", force: :cascade do |t|
    t.string  "name",                       null: false
    t.string  "locality",                   null: false
    t.string  "skill",                      null: false
    t.boolean "archived",   default: false, null: false
    t.integer "account_id"
    t.boolean "processed",  default: false, null: false
  end

  create_table "temp_leads", force: :cascade do |t|
    t.string  "url",                        null: false
    t.integer "query_id",                   null: false
    t.boolean "processed",  default: false, null: false
    t.integer "account_id",                 null: false
  end

  add_index "temp_leads", ["processed"], name: "index_temp_leads_on_processed", using: :btree
  add_index "temp_leads", ["query_id"], name: "index_temp_leads_on_query_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id", "invited_by_type"], name: "index_users_on_invited_by_id_and_invited_by_type", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
