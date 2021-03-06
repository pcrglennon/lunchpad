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

ActiveRecord::Schema.define(version: 20140823144600) do

  create_table "communities", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.integer  "community_id"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "time"
    t.string   "info"
    t.integer  "creator_id"
  end

  add_index "groups", ["community_id"], name: "index_groups_on_community_id"
  add_index "groups", ["restaurant_id"], name: "index_groups_on_restaurant_id"

  create_table "member_communities", force: true do |t|
    t.integer  "member_id"
    t.integer  "community_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "member_communities", ["community_id"], name: "index_member_communities_on_community_id"
  add_index "member_communities", ["member_id"], name: "index_member_communities_on_member_id"

  create_table "members", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "group_id"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true
  add_index "members", ["group_id"], name: "index_members_on_group_id"
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.string   "yelp_url"
    t.integer  "community_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "image_url"
  end

  add_index "restaurants", ["community_id"], name: "index_restaurants_on_community_id"
  add_index "restaurants", ["yelp_url"], name: "index_restaurants_on_yelp_url"

  create_table "reviews", force: true do |t|
    t.string   "text"
    t.float    "rating"
    t.integer  "restaurant_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["member_id"], name: "index_reviews_on_member_id"
  add_index "reviews", ["restaurant_id"], name: "index_reviews_on_restaurant_id"

end
