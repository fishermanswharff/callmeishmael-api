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

ActiveRecord::Schema.define(version: 20150425134424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "buttons", force: :cascade do |t|
    t.text     "assignment", null: false
    t.integer  "phone_id"
    t.integer  "story_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buttons", ["assignment"], name: "index_buttons_on_assignment", using: :btree
  add_index "buttons", ["phone_id"], name: "index_buttons_on_phone_id", using: :btree
  add_index "buttons", ["story_id"], name: "index_buttons_on_story_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.text     "unique_identifier",             null: false
    t.text     "token",                         null: false
    t.integer  "status",            default: 1, null: false
    t.text     "wifiSSID"
    t.text     "wifiPassword"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id"
  end

  add_index "phones", ["status"], name: "index_phones_on_status", using: :btree
  add_index "phones", ["unique_identifier"], name: "index_phones_on_unique_identifier", using: :btree
  add_index "phones", ["venue_id"], name: "index_phones_on_venue_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.text     "unique_identifier",                                     null: false
    t.text     "title",                                                 null: false
    t.integer  "type",                                      default: 1, null: false
    t.text     "author_last"
    t.text     "author_first"
    t.integer  "placements"
    t.integer  "listens"
    t.decimal  "percentage",        precision: 4, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stories", ["type"], name: "index_stories_on_type", using: :btree
  add_index "stories", ["unique_identifier"], name: "index_stories_on_unique_identifier", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "firstname"
    t.text     "lastname"
    t.text     "username"
    t.integer  "role",                             default: 1,     null: false
    t.text     "email"
    t.integer  "phonenumber",            limit: 8
    t.string   "password_digest"
    t.string   "token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.boolean  "active",                           default: true
    t.boolean  "main_store_contact",               default: false
    t.boolean  "main_business_contact",            default: false
    t.boolean  "confirmed",                        default: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "venues", force: :cascade do |t|
    t.text     "unique_identifier"
    t.text     "name",                             null: false
    t.boolean  "status",            default: true
    t.integer  "number_phones"
    t.integer  "post_roll_listens"
    t.integer  "total_stories"
    t.uuid     "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["name"], name: "index_venues_on_name", using: :btree
  add_index "venues", ["unique_identifier"], name: "index_venues_on_unique_identifier", using: :btree

end
