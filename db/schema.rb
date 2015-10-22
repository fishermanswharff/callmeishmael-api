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

ActiveRecord::Schema.define(version: 20151022005510) do

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

  create_table "phonelogs", force: :cascade do |t|
    t.text     "log_content"
    t.integer  "phone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", force: :cascade do |t|
    t.text     "unique_identifier"
    t.text     "token",                         null: false
    t.integer  "status",            default: 0, null: false
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
    t.text     "unique_identifier"
    t.text     "title",                                                        null: false
    t.text     "url",                                                          null: false
    t.integer  "story_type",                                default: 1,        null: false
    t.text     "author_last"
    t.text     "author_first"
    t.integer  "placements",                                default: 0,        null: false
    t.integer  "listens",                                   default: 0,        null: false
    t.decimal  "percentage",        precision: 4, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "call_length"
    t.string   "common_title"
    t.date     "call_date"
    t.boolean  "spoiler_alert",                             default: false,    null: false
    t.boolean  "child_appropriate",                         default: true,     null: false
    t.boolean  "explicit",                                  default: false,    null: false
    t.string   "gender",                                    default: "Female", null: false
    t.integer  "rating",                                    default: 1,        null: false
    t.string   "transcript_url"
    t.integer  "call_uuid"
    t.string   "md5_url"
  end

  add_index "stories", ["story_type"], name: "index_stories_on_story_type", using: :btree
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

  create_table "users_venues", force: :cascade do |t|
    t.integer "venue_id"
    t.uuid    "user_id"
  end

  create_table "venues", force: :cascade do |t|
    t.text     "unique_identifier"
    t.text     "name",                             null: false
    t.boolean  "status",            default: true
    t.integer  "number_phones",     default: 0,    null: false
    t.integer  "post_roll_listens", default: 0,    null: false
    t.integer  "total_stories",     default: 0,    null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "total_listens",     default: 0,    null: false
    t.integer  "venue_status",      default: 0,    null: false
  end

  add_index "venues", ["name"], name: "index_venues_on_name", using: :btree
  add_index "venues", ["unique_identifier"], name: "index_venues_on_unique_identifier", using: :btree

  create_table "venuestories", force: :cascade do |t|
    t.integer  "venue_id"
    t.integer  "story_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venuestories", ["story_id"], name: "index_venuestories_on_story_id", using: :btree
  add_index "venuestories", ["venue_id"], name: "index_venuestories_on_venue_id", using: :btree

  add_foreign_key "venuestories", "stories", on_delete: :cascade
  add_foreign_key "venuestories", "venues", on_delete: :cascade
end
