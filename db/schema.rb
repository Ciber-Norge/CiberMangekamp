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

ActiveRecord::Schema.define(version: 20160124100839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "season_id"
    t.date     "date",        null: false
    t.string   "title",       null: false
    t.string   "sport",       null: false
    t.string   "venue"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  add_index "events", ["category_id"], name: "index_events_on_category_id", using: :btree
  add_index "events", ["season_id"], name: "index_events_on_season_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "participants", ["event_id"], name: "index_participants_on_event_id", using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.integer  "participant_id"
    t.integer  "event_id"
    t.integer  "rank",           null: false
    t.string   "score"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "results", ["event_id"], name: "index_results_on_event_id", using: :btree
  add_index "results", ["participant_id"], name: "index_results_on_participant_id", using: :btree

  create_table "seasons", force: :cascade do |t|
    t.integer  "year",       limit: 2, null: false
    t.string   "title"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sex",        null: false
  end

  add_foreign_key "events", "categories"
end
