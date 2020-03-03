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

ActiveRecord::Schema.define(version: 2020_03_03_025947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.bigint "post_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_comments_on_event_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "music_style_id"
    t.string "city"
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.text "description"
    t.integer "max_players"
    t.integer "status", default: 0
    t.date "start_date"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.time "start_time"
    t.string "country"
    t.index ["music_style_id"], name: "index_events_on_music_style_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "instrument_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "instrument_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_instrument_users_on_instrument_id"
    t.index ["user_id"], name: "index_instrument_users_on_user_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "name"
    t.string "classification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "music_styles", force: :cascade do |t|
    t.string "style"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_participants_on_event_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "city"
    t.string "last_name"
    t.date "birth_date"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "participant_id"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_ratings_on_participant_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "events"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "events", "music_styles"
  add_foreign_key "events", "users"
  add_foreign_key "followers", "users"
  add_foreign_key "instrument_users", "instruments"
  add_foreign_key "instrument_users", "users"
  add_foreign_key "participants", "events"
  add_foreign_key "participants", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "ratings", "participants"
  add_foreign_key "ratings", "users"
end
