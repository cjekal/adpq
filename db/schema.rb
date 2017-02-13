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

ActiveRecord::Schema.define(version: 20170213165811) do

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "category",                                      null: false
    t.string   "unique_identifier",                             null: false
    t.string   "zip_code"
    t.string   "additional_info_url"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "endpoint"
    t.integer  "layer"
    t.decimal  "latitude",            precision: 15, scale: 10
    t.decimal  "longitude",           precision: 15, scale: 10
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "resident_id"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["event_id"], name: "index_notifications_on_event_id", using: :btree
    t.index ["resident_id"], name: "index_notifications_on_resident_id", using: :btree
  end

  create_table "residents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "zip_code",                 null: false
    t.string   "last_known_zip_code"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "subscription_endpoint"
    t.string   "subscription_keys_p256dh"
    t.string   "subscription_keys_auth"
  end

  add_foreign_key "notifications", "events"
  add_foreign_key "notifications", "residents"
end
