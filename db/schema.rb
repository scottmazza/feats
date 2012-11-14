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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121112224943) do

  create_table "attempts", :force => true do |t|
    t.integer  "feat_id"
    t.integer  "user_id"
    t.float    "score"
    t.string   "video_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  add_index "attempts", ["feat_id"], :name => "index_attempts_on_feat_id"
  add_index "attempts", ["user_id"], :name => "index_attempts_on_user_id"

  create_table "feats", :force => true do |t|
    t.integer  "location_id"
    t.text     "description"
    t.boolean  "low_score_wins"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "user_id"
    t.string   "name"
    t.boolean  "timed"
  end

  add_index "feats", ["location_id"], :name => "index_feats_on_location_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "address"
  end

  add_index "locations", ["latitude"], :name => "index_locations_on_latitude"
  add_index "locations", ["longitude"], :name => "index_locations_on_longitude"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "username"
    t.string   "image"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "oauth_provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "validations", :force => true do |t|
    t.integer  "attempt_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "rebuttal",   :default => false
  end

  add_index "validations", ["attempt_id"], :name => "index_validations_on_attempt_id"
  add_index "validations", ["user_id"], :name => "index_validations_on_user_id"

end
