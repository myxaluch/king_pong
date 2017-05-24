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

ActiveRecord::Schema.define(version: 20170504125321) do

  create_table "games", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "player_one_id"
    t.integer  "player_two_id"
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.string   "state"
    t.integer  "winner_points", default: 0
    t.integer  "loser_points",  default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["loser_id"], name: "index_games_on_loser_id", using: :btree
    t.index ["player_one_id"], name: "index_games_on_player_one_id", using: :btree
    t.index ["player_two_id"], name: "index_games_on_player_two_id", using: :btree
    t.index ["winner_id"], name: "index_games_on_winner_id", using: :btree
  end

  create_table "players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "total_games_count",             default: 0,   null: false
    t.integer  "win_games_count",               default: 0,   null: false
    t.integer  "lose_games_count",              default: 0,   null: false
    t.float    "win_balls_average",  limit: 24, default: 0.0, null: false
    t.float    "lose_balls_average", limit: 24, default: 0.0, null: false
    t.float    "weight",             limit: 24, default: 0.0, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

end
