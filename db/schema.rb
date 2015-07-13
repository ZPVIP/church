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

ActiveRecord::Schema.define(version: 20150713210518) do

  create_table "calendars", force: :cascade do |t|
    t.date     "datum"
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.integer  "lft",        limit: 4
    t.integer  "rgt",        limit: 4
    t.integer  "depth",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calendars", ["depth"], name: "index_calendars_on_depth", using: :btree
  add_index "calendars", ["lft"], name: "index_calendars_on_lft", using: :btree
  add_index "calendars", ["parent_id"], name: "index_calendars_on_parent_id", using: :btree
  add_index "calendars", ["rgt"], name: "index_calendars_on_rgt", using: :btree

  create_table "contact_gatherings", force: :cascade do |t|
    t.integer  "contact_id",   limit: 4
    t.integer  "gathering_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_groups", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "contact_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "gender",             limit: 4
    t.string   "telephone",          limit: 255
    t.string   "mobile",             limit: 255
    t.string   "email",              limit: 255
    t.string   "address",            limit: 255
    t.date     "birthday"
    t.text     "comment",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "come"
    t.date     "go"
    t.date     "decision"
    t.string   "decision_with",      limit: 255
    t.date     "baptism"
    t.string   "wechat",             limit: 255
    t.string   "job",                limit: 255
    t.integer  "find_us",            limit: 4
    t.string   "find_us_additional", limit: 255
    t.integer  "friend_id",          limit: 4
    t.text     "pray",               limit: 65535
    t.boolean  "authenticated",      limit: 1,     default: false
    t.string   "native_place",       limit: 255
    t.string   "register_ip",        limit: 255
    t.integer  "birth_month",        limit: 4
    t.string   "spouse",             limit: 255
    t.integer  "user_id",            limit: 4
    t.boolean  "unknown_year",       limit: 1
    t.boolean  "unknown_birthday",   limit: 1
  end

  add_index "contacts", ["authenticated"], name: "index_contacts_on_authenticated", using: :btree
  add_index "contacts", ["birth_month"], name: "index_contacts_on_birth_month", using: :btree
  add_index "contacts", ["birthday"], name: "index_contacts_on_birthday", using: :btree
  add_index "contacts", ["created_at"], name: "index_contacts_on_created_at", using: :btree
  add_index "contacts", ["name"], name: "index_contacts_on_name", using: :btree
  add_index "contacts", ["unknown_birthday"], name: "index_contacts_on_unknown_birthday", using: :btree
  add_index "contacts", ["unknown_year"], name: "index_contacts_on_unknown_year", using: :btree

  create_table "gatherings", force: :cascade do |t|
    t.string   "gathering",   limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "action",      limit: 255
    t.string   "subject",     limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["description"], name: "index_permissions_on_description", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "parent_id",  limit: 4
    t.integer  "lft",        limit: 4
    t.integer  "rgt",        limit: 4
    t.integer  "depth",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["depth"], name: "index_services_on_depth", using: :btree
  add_index "services", ["lft"], name: "index_services_on_lft", using: :btree
  add_index "services", ["parent_id"], name: "index_services_on_parent_id", using: :btree
  add_index "services", ["rgt"], name: "index_services_on_rgt", using: :btree

  create_table "user_contacts", id: false, force: :cascade do |t|
    t.integer "user_id",    limit: 4
    t.integer "contact_id", limit: 4
  end

  add_index "user_contacts", ["contact_id", "user_id"], name: "index_user_contacts_on_contact_id_and_user_id", using: :btree
  add_index "user_contacts", ["user_id", "contact_id"], name: "index_user_contacts_on_user_id_and_contact_id", using: :btree

  create_table "user_permissions", id: false, force: :cascade do |t|
    t.integer "permission_id", limit: 4
    t.integer "user_id",       limit: 4
  end

  add_index "user_permissions", ["permission_id", "user_id"], name: "index_user_permissions_on_permission_id_and_user_id", using: :btree
  add_index "user_permissions", ["user_id", "permission_id"], name: "index_user_permissions_on_user_id_and_permission_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.boolean  "blocked",                limit: 1,   default: false
    t.string   "username",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
