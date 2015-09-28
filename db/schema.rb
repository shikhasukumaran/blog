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

ActiveRecord::Schema.define(version: 20150831042909) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "auctions", force: true do |t|
    t.string   "name",                 limit: 80,                          null: false
    t.text     "description"
    t.string   "auction_type"
    t.string   "donor_name"
    t.boolean  "can_multiple_bid_win"
    t.decimal  "fair_market_value",               precision: 10, scale: 2
    t.integer  "winning_bid_number"
    t.integer  "quantity"
    t.integer  "event_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auctions", ["event_id"], name: "index_auctions_on_event_id"
  add_index "auctions", ["name"], name: "unique_name_index", unique: true

  create_table "bids", force: true do |t|
    t.string   "bid_number"
    t.decimal  "bid_amount", precision: 10, scale: 2
    t.boolean  "is_winner"
    t.integer  "guest_id"
    t.integer  "auction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["auction_id"], name: "index_bids_on_auction_id"
  add_index "bids", ["guest_id"], name: "index_bids_on_guest_id"

  create_table "comments", force: true do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id"

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guests", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "billing_address_1"
    t.string   "billing_address_2"
    t.string   "email"
    t.integer  "phone_number"
    t.integer  "bid_number"
    t.string   "table_number"
    t.integer  "dinner_tickets"
    t.decimal  "registration",      precision: 10, scale: 2
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
