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

ActiveRecord::Schema.define(version: 20150726094009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "artists", ["name"], name: "index_artists_on_name", using: :btree

  create_table "djs", force: :cascade do |t|
    t.string "alias", limit: 255, null: false
    t.string "email", limit: 255, null: false
  end

  add_index "djs", ["email"], name: "index_djs_on_email", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "age"
    t.text     "address"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start",                   null: false
    t.datetime "end"
    t.string   "description", limit: 255
    t.integer  "place_id",                null: false
  end

  create_table "listener_song_requests", id: false, force: :cascade do |t|
    t.integer  "listener_id", null: false
    t.integer  "song_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "listener_song_requests", ["listener_id"], name: "index_listener_song_requests_on_listener_id", using: :btree
  add_index "listener_song_requests", ["song_id"], name: "index_listener_song_requests_on_song_id", using: :btree

  create_table "listeners", force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "email",      limit: 255, null: false
  end

  add_index "listeners", ["email"], name: "index_listeners_on_email", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "event_id",   null: false
    t.integer  "dj_id",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reservations", ["dj_id"], name: "index_reservations_on_dj_id", using: :btree
  add_index "reservations", ["event_id"], name: "index_reservations_on_event_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string  "name",      limit: 255
    t.integer "artist_id"
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id", using: :btree
  add_index "songs", ["name"], name: "index_songs_on_name", using: :btree

  add_foreign_key "listener_song_requests", "listeners"
  add_foreign_key "listener_song_requests", "songs"
  add_foreign_key "reservations", "djs"
  add_foreign_key "reservations", "events"
  add_foreign_key "songs", "artists"
end
