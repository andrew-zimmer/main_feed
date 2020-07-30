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

ActiveRecord::Schema.define(version: 2020_07_29_232009) do

  create_table "badges", force: :cascade do |t|
    t.string "issuer"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foremen", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_foremen_on_user_id"
  end

  create_table "helpers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "foreman_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["foreman_id"], name: "index_helpers_on_foreman_id"
    t.index ["user_id"], name: "index_helpers_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "project_number"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "construction_type"
    t.boolean "finish", default: false
    t.boolean "started", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_schedules_on_project_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0
    t.integer "phone_number"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.integer "expires_at"
    t.boolean "expires"
    t.string "refresh_token"
    t.string "construction_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_badges", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "badge_id", null: false
    t.datetime "expiration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["badge_id"], name: "index_users_badges_on_badge_id"
    t.index ["user_id"], name: "index_users_badges_on_user_id"
  end

  add_foreign_key "foremen", "users"
  add_foreign_key "helpers", "foremen"
  add_foreign_key "helpers", "users"
  add_foreign_key "schedules", "projects"
  add_foreign_key "schedules", "users"
  add_foreign_key "users_badges", "badges"
  add_foreign_key "users_badges", "users"
end
