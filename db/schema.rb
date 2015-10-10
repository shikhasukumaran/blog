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

ActiveRecord::Schema.define(version: 20151008223641) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "auctions", force: true do |t|
    t.string   "name",               limit: 80,                          null: false
    t.text     "description"
    t.string   "auction_type"
    t.integer  "donor_id"
    t.decimal  "fair_market_value",             precision: 10, scale: 2
    t.integer  "winning_bid_number"
    t.integer  "event_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auctions", ["event_id"], name: "index_auctions_on_event_id"
  add_index "auctions", ["name"], name: "unique_name_index", unique: true

  create_table "bid_numbers", force: true do |t|
    t.integer  "bid_number"
    t.decimal  "event_due_amount",     precision: 10, scale: 2
    t.string   "event_due_pay_status"
    t.string   "invoice_email_status"
    t.decimal  "fee_adjustment",       precision: 10, scale: 2
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bid_numbers", ["event_id"], name: "index_bid_numbers_on_event_id"

  create_table "bids", force: true do |t|
    t.string   "bid_number"
    t.string   "auction_type"
    t.decimal  "bid_amount",         precision: 10, scale: 2
    t.integer  "quantity_purchased"
    t.boolean  "is_winner"
    t.integer  "auction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["auction_id"], name: "index_bids_on_auction_id"

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
    t.string   "guest_of"
    t.string   "billing_address_1"
    t.string   "billing_address_2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "email"
    t.string   "phone_number"
    t.integer  "bid_number"
    t.string   "table_number"
    t.integer  "dinner_tickets"
    t.string   "registration_status"
    t.decimal  "registration_fee",      precision: 10, scale: 2
    t.string   "registration_fee_mode"
    t.string   "event_status"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guests", ["event_id"], name: "index_guests_on_event_id"

  create_table "invoice_entries", force: true do |t|
    t.integer  "auction_id"
    t.string   "auction_type"
    t.integer  "bid_id"
    t.decimal  "bid_amount",         precision: 10, scale: 2
    t.integer  "quantity_purchased"
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoice_entries", ["invoice_id"], name: "index_invoice_entries_on_invoice_id"

  create_table "invoices", force: true do |t|
    t.integer  "version"
    t.datetime "creation_date"
    t.string   "status"
    t.integer  "bid_number_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["bid_number_id"], name: "index_invoices_on_bid_number_id"

end
