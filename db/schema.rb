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

ActiveRecord::Schema.define(version: 20150731184154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "artists", ["name"], name: "index_artists_on_name", using: :btree

  create_table "listener_song_requests", force: :cascade do |t|
    t.integer  "longitude",   null: false
    t.integer  "latitude",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "listener_id", null: false
    t.integer  "song_id",     null: false
  end

  add_index "listener_song_requests", ["listener_id"], name: "index_listener_song_requests_on_listener_id", using: :btree
  add_index "listener_song_requests", ["song_id"], name: "index_listener_song_requests_on_song_id", using: :btree

  create_table "listeners", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "person_type", limit: 255
    t.float    "latitude",                null: false
    t.float    "longitude",               null: false
    t.string   "socket_ip",   limit: 255, null: false
    t.integer  "socket_port",             null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "locations", ["latitude"], name: "index_locations_on_latitude", using: :btree
  add_index "locations", ["longitude"], name: "index_locations_on_longitude", using: :btree
  add_index "locations", ["person_type", "person_id"], name: "index_locations_on_person_type_and_person_id", using: :btree

  create_table "music_jockey_song_requests", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "music_jockey_id",          null: false
    t.integer  "listener_song_request_id", null: false
  end

  add_index "music_jockey_song_requests", ["listener_song_request_id"], name: "index_music_jockey_song_requests_on_listener_song_request_id", using: :btree
  add_index "music_jockey_song_requests", ["music_jockey_id"], name: "index_music_jockey_song_requests_on_music_jockey_id", using: :btree

  create_table "music_jockeys", force: :cascade do |t|
    t.string   "stage_name", limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "person_details", force: :cascade do |t|
    t.string  "email",       limit: 255
    t.integer "person_id",               null: false
    t.string  "person_type", limit: 255, null: false
  end

  add_index "person_details", ["email"], name: "index_person_details_on_email", using: :btree
  add_index "person_details", ["person_type", "person_id"], name: "index_person_details_on_person_type_and_person_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "start_time",                  null: false
    t.datetime "end_time"
    t.string   "description",     limit: 255
    t.integer  "place_id",                    null: false
    t.integer  "music_jockey_id",             null: false
    t.integer  "listener_id",                 null: false
    t.integer  "song_id",                     null: false
  end

  add_index "reservations", ["listener_id"], name: "index_reservations_on_listener_id", using: :btree
  add_index "reservations", ["music_jockey_id"], name: "index_reservations_on_music_jockey_id", using: :btree
  add_index "reservations", ["song_id"], name: "index_reservations_on_song_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "artist_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id", using: :btree
  add_index "songs", ["name"], name: "index_songs_on_name", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "listener_song_requests", "listeners"
  add_foreign_key "listener_song_requests", "songs"
  add_foreign_key "music_jockey_song_requests", "listener_song_requests"
  add_foreign_key "music_jockey_song_requests", "music_jockeys"
  add_foreign_key "reservations", "listeners"
  add_foreign_key "reservations", "music_jockeys"
  add_foreign_key "reservations", "songs"
  add_foreign_key "songs", "artists"
end
