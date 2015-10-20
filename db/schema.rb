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

ActiveRecord::Schema.define(version: 20151019223313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "category"
    t.string   "subcategory"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "category_name"
    t.string   "name"
    t.string   "subname"
    t.integer  "pantry_dop_min"
    t.integer  "pantry_dop_max"
    t.string   "pantry_dop_metric"
    t.string   "pantry_tips"
    t.integer  "fridge_dop_min"
    t.integer  "fridge_dop_max"
    t.string   "fridge_dop_metric"
    t.integer  "fridge_open_min"
    t.integer  "fridge_open_max"
    t.string   "fridge_open_metric"
    t.integer  "fridge_after_thawing_min"
    t.integer  "fridge_after_thawing_max"
    t.string   "fridge_after_thawing_metric"
    t.string   "fridge_tips"
    t.integer  "freezer_dop_min"
    t.integer  "freezer_dop_max"
    t.string   "freezer_dop_metric"
    t.string   "freezer_tips"
    t.boolean  "user_data",                   default: false
    t.boolean  "fridge",                      default: false
    t.boolean  "pantry",                      default: false
    t.boolean  "freezer",                     default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "user_products", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "location"
    t.datetime "dop_expiration_date_min"
    t.datetime "dop_expiration_date_max"
    t.datetime "thawed_expiration_date_min"
    t.datetime "thawed_expiration_date_max"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_products", ["product_id"], name: "index_user_products_on_product_id", using: :btree
  add_index "user_products", ["user_id"], name: "index_user_products_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "password_digest"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "products", "categories"
end
