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

ActiveRecord::Schema.define(version: 20140610211427) do

  create_table "contact_gatherings", force: true do |t|
    t.integer  "contact_id"
    t.integer  "gathering_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_groups", force: true do |t|
    t.integer  "group_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.integer  "gender"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "email"
    t.string   "address"
    t.date     "birthday"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "come"
    t.date     "go"
    t.date     "decision"
    t.string   "decision_with"
    t.date     "baptism"
    t.string   "wechat"
    t.string   "job"
    t.integer  "find_us"
    t.string   "find_us_additional"
    t.integer  "friend_id"
    t.text     "pray"
    t.boolean  "authenticated",      default: false
    t.string   "native_place"
    t.string   "register_ip"
  end

  add_index "contacts", ["birthday"], name: "index_contacts_on_birthday", using: :btree
  add_index "contacts", ["created_at"], name: "index_contacts_on_created_at", using: :btree
  add_index "contacts", ["name"], name: "index_contacts_on_name", using: :btree

  create_table "gatherings", force: true do |t|
    t.string   "gathering"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: true do |t|
    t.string   "action"
    t.string   "subject"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_users", id: false, force: true do |t|
    t.integer "permission_id"
    t.integer "user_id"
  end

  add_index "permissions_users", ["permission_id", "user_id"], name: "index_permissions_users_on_permission_id_and_user_id", using: :btree
  add_index "permissions_users", ["user_id", "permission_id"], name: "index_permissions_users_on_user_id_and_permission_id", using: :btree

  create_table "services", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["depth"], name: "index_services_on_depth", using: :btree
  add_index "services", ["lft"], name: "index_services_on_lft", using: :btree
  add_index "services", ["parent_id"], name: "index_services_on_parent_id", using: :btree
  add_index "services", ["rgt"], name: "index_services_on_rgt", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "blocked",                default: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
