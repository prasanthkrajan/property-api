# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_10_26_084000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favourite_properties", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_favourite_properties_on_property_id"
    t.index ["user_id"], name: "index_favourite_properties_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.decimal "rent", precision: 8, scale: 2
    t.string "currency"
    t.string "full_address"
    t.string "unit_type"
    t.integer "bedroom"
    t.integer "bathroom"
    t.string "closest_mrt"
    t.decimal "floor_size_in_ping", precision: 8, scale: 2
    t.decimal "floor_size_in_sqft", precision: 8, scale: 2
    t.string "city"
    t.string "district"
    t.string "title"
    t.text "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favourite_properties", "properties"
  add_foreign_key "favourite_properties", "users"
end
