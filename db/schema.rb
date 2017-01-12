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

ActiveRecord::Schema.define(version: 20161230061038) do

  create_table "age_ranges", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "age",        limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ciner_videos", force: :cascade do |t|
    t.string   "original_title",    limit: 255
    t.string   "title",             limit: 255
    t.integer  "year",              limit: 4
    t.string   "length",            limit: 255
    t.text     "synopsis",          limit: 65535
    t.datetime "release"
    t.datetime "brazilian_release"
    t.integer  "city_id",           limit: 4
    t.integer  "state_id",          limit: 4
    t.integer  "country_id",        limit: 4
    t.integer  "age_range_id",      limit: 4
    t.string   "cover",             limit: 255
    t.integer  "studio_id",         limit: 4
    t.date     "approval"
    t.integer  "user_id",           limit: 4
    t.integer  "approver_id",       limit: 4
    t.integer  "owner_id",          limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "state_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "acronym",    limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "critics", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "city_id",       limit: 4
    t.integer  "state_id",      limit: 4
    t.integer  "country_id",    limit: 4
    t.integer  "filmable_id",   limit: 4
    t.string   "filmable_type", limit: 255
    t.string   "name",          limit: 255
    t.text     "content",       limit: 65535
    t.integer  "rating",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "critics", ["filmable_type", "filmable_id"], name: "index_critics_on_filmable_type_and_filmable_id", using: :btree
  add_index "critics", ["user_id"], name: "index_critics_on_user_id", using: :btree

  create_table "film_production_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "film_productions", force: :cascade do |t|
    t.string   "original_title",    limit: 255
    t.string   "title",             limit: 255
    t.integer  "year",              limit: 4
    t.string   "length",            limit: 255
    t.text     "synopsis",          limit: 65535
    t.datetime "release"
    t.datetime "brazilian_release"
    t.integer  "city_id",           limit: 4
    t.integer  "state_id",          limit: 4
    t.integer  "country_id",        limit: 4
    t.integer  "age_range_id",      limit: 4
    t.string   "cover",             limit: 255
    t.integer  "type",              limit: 4
    t.integer  "studio_id",         limit: 4
    t.date     "approval"
    t.integer  "user_id",           limit: 4
    t.integer  "approver_id",       limit: 4
    t.integer  "owner_id",          limit: 4
    t.integer  "season",            limit: 4
    t.integer  "number_episodes",   limit: 4
    t.integer  "aired_episodes",    limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string   "original_title",    limit: 255
    t.string   "title",             limit: 255
    t.integer  "year",              limit: 4
    t.string   "length",            limit: 255
    t.text     "synopsis",          limit: 65535
    t.datetime "release"
    t.datetime "brazilian_release"
    t.integer  "city_id",           limit: 4
    t.integer  "state_id",          limit: 4
    t.integer  "country_id",        limit: 4
    t.integer  "age_range_id",      limit: 4
    t.string   "cover",             limit: 255
    t.integer  "studio_id",         limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "professionals", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "gender",          limit: 4
    t.string   "nickname",        limit: 255
    t.date     "birthday"
    t.integer  "age",             limit: 4
    t.string   "cep",             limit: 255
    t.string   "address",         limit: 255
    t.string   "number",          limit: 255
    t.string   "neighbourhood",   limit: 255
    t.string   "complement",      limit: 255
    t.string   "cpf",             limit: 255
    t.string   "phone",           limit: 255
    t.string   "mobile",          limit: 255
    t.string   "avatar",          limit: 255
    t.text     "biography",       limit: 65535
    t.integer  "city_id",         limit: 4
    t.integer  "state_id",        limit: 4
    t.integer  "country_id",      limit: 4
    t.integer  "set_function_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "professionals", ["city_id"], name: "index_professionals_on_city_id", using: :btree
  add_index "professionals", ["country_id"], name: "index_professionals_on_country_id", using: :btree
  add_index "professionals", ["state_id"], name: "index_professionals_on_state_id", using: :btree

  create_table "series", force: :cascade do |t|
    t.string   "original_title",    limit: 255
    t.string   "title",             limit: 255
    t.integer  "year",              limit: 4
    t.string   "length",            limit: 255
    t.text     "synopsis",          limit: 65535
    t.datetime "release"
    t.datetime "brazilian_release"
    t.integer  "city_id",           limit: 4
    t.integer  "state_id",          limit: 4
    t.integer  "country_id",        limit: 4
    t.integer  "age_range_id",      limit: 4
    t.string   "cover",             limit: 255
    t.integer  "studio_id",         limit: 4
    t.integer  "season",            limit: 4
    t.integer  "number_episodes",   limit: 4
    t.integer  "aired_episodes",    limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "set_functions", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "set_functions", ["user_id"], name: "index_set_functions_on_user_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "acronym",    limit: 255
    t.string   "name",       limit: 255
    t.integer  "country_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "states", ["country_id"], name: "index_states_on_country_id", using: :btree

  create_table "studios", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "country_id", limit: 4
    t.integer  "state_id",   limit: 4
    t.integer  "city_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "name",                   limit: 255
    t.integer  "gender",                 limit: 4
    t.string   "nickname",               limit: 255
    t.date     "birthday"
    t.integer  "age",                    limit: 4
    t.string   "cep",                    limit: 255
    t.string   "address",                limit: 255
    t.string   "number",                 limit: 255
    t.string   "neighbourhood",          limit: 255
    t.string   "complement",             limit: 255
    t.integer  "role",                   limit: 4
    t.string   "cpf",                    limit: 255
    t.string   "phone",                  limit: 255
    t.string   "mobile",                 limit: 255
    t.string   "avatar",                 limit: 255
    t.text     "biography",              limit: 65535
    t.boolean  "terms_of_use",                         default: false
    t.boolean  "accepted_term_of_use"
    t.date     "registered_at"
    t.integer  "city_id",                limit: 4
    t.integer  "state_id",               limit: 4
    t.integer  "country_id",             limit: 4
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "users", ["city_id"], name: "index_users_on_city_id", using: :btree
  add_index "users", ["country_id"], name: "index_users_on_country_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["state_id"], name: "index_users_on_state_id", using: :btree

  add_foreign_key "set_functions", "users"
end
