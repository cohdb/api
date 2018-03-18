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

ActiveRecord::Schema.define(version: 20170727165623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_messages", force: :cascade do |t|
    t.integer  "player_id",  null: false
    t.integer  "tick",       null: false
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_chat_messages_on_player_id", using: :btree
  end

  create_table "commands", force: :cascade do |t|
    t.integer  "player_id",          null: false
    t.integer  "internal_player_id", null: false
    t.integer  "tick",               null: false
    t.string   "command_type",       null: false
    t.integer  "entity_id",          null: false
    t.decimal  "x"
    t.decimal  "y"
    t.decimal  "z"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["player_id"], name: "index_commands_on_player_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.integer  "replay_id",   null: false
    t.integer  "internal_id", null: false
    t.string   "name",        null: false
    t.string   "steam_id",    null: false
    t.string   "faction",     null: false
    t.integer  "team"
    t.string   "commander"
    t.decimal  "cpm"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["replay_id"], name: "index_players_on_replay_id", using: :btree
  end

  create_table "replays", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "version",          null: false
    t.integer  "length",           null: false
    t.string   "map",              null: false
    t.bigint   "rng_seed"
    t.string   "opponent_type"
    t.string   "game_type"
    t.datetime "recorded_at"
    t.string   "rec_file_name"
    t.string   "rec_content_type"
    t.integer  "rec_file_size"
    t.datetime "rec_updated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_replays_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",                        null: false
    t.string   "uid",                             null: false
    t.string   "name"
    t.string   "nickname"
    t.string   "location"
    t.string   "image"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true, using: :btree
  end

end
