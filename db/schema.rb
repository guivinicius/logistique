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

ActiveRecord::Schema.define(version: 20140503141727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "edges", force: true do |t|
    t.integer  "source"
    t.integer  "target"
    t.float    "cost"
    t.integer  "map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "edges", ["map_id"], name: "index_edges_on_map_id", using: :btree

  create_table "maps", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "maps", ["name"], name: "index_maps_on_name", unique: true, using: :btree

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.integer  "map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodes", ["map_id", "name"], name: "index_nodes_on_map_id_and_name", unique: true, using: :btree
  add_index "nodes", ["map_id"], name: "index_nodes_on_map_id", using: :btree

end
