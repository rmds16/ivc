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

ActiveRecord::Schema.define(version: 20171105203909) do

  create_table "ahoy_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "token"
    t.text     "to",              limit: 65535
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "mailer"
    t.text     "subject",         limit: 65535
    t.datetime "sent_at"
    t.datetime "opened_at"
    t.datetime "clicked_at"
    t.integer  "events_users_id"
    t.index ["token"], name: "index_ahoy_messages_on_token", using: :btree
    t.index ["user_id", "user_type"], name: "index_ahoy_messages_on_user_id_and_user_type", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "where"
    t.string   "post_map_ref"
    t.text     "public_description",     limit: 65535
    t.integer  "organiser_id"
    t.string   "fee"
    t.datetime "book_by_date"
    t.integer  "user_id"
    t.boolean  "featured_event",                       default: false
    t.boolean  "approved",                             default: false
    t.boolean  "show_to_users",                        default: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "organiser_email"
    t.string   "organiser_phone"
    t.integer  "second_organiser_id"
    t.string   "second_organiser_email"
    t.string   "second_organiser_phone"
  end

  create_table "events_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "event_id",                       null: false
    t.integer "user_id",                        null: false
    t.boolean "organiser_read", default: false
    t.index ["event_id", "user_id"], name: "index_events_users_on_event_id_and_user_id", using: :btree
    t.index ["user_id", "event_id"], name: "index_events_users_on_user_id_and_event_id", using: :btree
  end

  create_table "user_sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "session_id",               null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["session_id"], name: "index_user_sessions_on_session_id", using: :btree
    t.index ["updated_at"], name: "index_user_sessions_on_updated_at", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "first_name"
    t.string   "surname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",         default: 0,     null: false
    t.integer  "failed_login_count",  default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",               default: false
    t.string   "phone"
  end

end
