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

ActiveRecord::Schema.define(version: 20140520202818) do

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
  end

  add_index "contacts", ["birthday"], name: "index_contacts_on_birthday", using: :btree
  add_index "contacts", ["created_at"], name: "index_contacts_on_created_at", using: :btree
  add_index "contacts", ["name"], name: "index_contacts_on_name", using: :btree

  create_table "group_contacts", force: true do |t|
    t.integer  "group_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
