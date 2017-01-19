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

ActiveRecord::Schema.define(version: 20170118175605) do

  create_table "events", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "where",               limit: 255
    t.string   "post_map_ref",        limit: 255
    t.string   "country",             limit: 255
    t.string   "eventbrite_id",       limit: 255
    t.string   "web_link",            limit: 255
    t.string   "venue_web_link",      limit: 255
    t.text     "public_description",  limit: 65535
    t.text     "private_description", limit: 65535
    t.text     "organiser",           limit: 65535
    t.text     "how_to_find_us",      limit: 65535
    t.string   "fee",                 limit: 255
    t.datetime "book_by_date"
    t.integer  "attendee_limit",      limit: 4
    t.integer  "user_id",             limit: 4
    t.integer  "display_level",       limit: 4
    t.boolean  "allow_bookings",                    default: false
    t.boolean  "featured_event",                    default: false
    t.boolean  "approved",                          default: false
    t.boolean  "show_to_users"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "user_sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "user_sessions", ["session_id"], name: "index_user_sessions_on_session_id", using: :btree
  add_index "user_sessions", ["updated_at"], name: "index_user_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",          limit: 255
    t.string   "surname",             limit: 255
    t.string   "email",               limit: 255
    t.string   "crypted_password",    limit: 255
    t.string   "password_salt",       limit: 255
    t.string   "persistence_token",   limit: 255
    t.string   "single_access_token", limit: 255
    t.string   "perishable_token",    limit: 255
    t.integer  "login_count",         limit: 4,   default: 0, null: false
    t.integer  "failed_login_count",  limit: 4,   default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",    limit: 255
    t.string   "last_login_ip",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
