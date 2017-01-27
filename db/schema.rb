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

ActiveRecord::Schema.define(version: 20170127033142) do

  create_table "age_ranges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ciner_videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "original_title"
    t.string   "title"
    t.integer  "year"
    t.string   "length"
    t.text     "synopsis",          limit: 65535
    t.datetime "release"
    t.datetime "brazilian_release"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "age_range_id"
    t.string   "cover"
    t.integer  "studio_id"
    t.date     "approval"
    t.integer  "user_id"
    t.integer  "approver_id"
    t.integer  "owner_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type", using: :btree
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "acronym"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "critics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "filmable_type"
    t.integer  "filmable_id"
    t.text     "content",               limit: 65535
    t.float    "rating",                limit: 24
    t.integer  "filmable_release_year"
    t.integer  "status",                              default: 1
    t.integer  "origin",                              default: 2
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["filmable_type", "filmable_id"], name: "index_critics_on_filmable_type_and_filmable_id", using: :btree
    t.index ["user_id"], name: "index_critics_on_user_id", using: :btree
  end

  create_table "film_production_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "film_productions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "original_title"
    t.string   "title"
    t.integer  "year"
    t.string   "length"
    t.text     "synopsis",          limit: 65535
    t.datetime "release"
    t.datetime "brazilian_release"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "age_range_id"
    t.string   "cover"
    t.integer  "type"
    t.integer  "studio_id"
    t.date     "approval"
    t.integer  "user_id"
    t.integer  "approver_id"
    t.integer  "owner_id"
    t.integer  "season"
    t.integer  "number_episodes"
    t.integer  "aired_episodes"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "filmable_professionals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "filmable_type"
    t.integer "filmable_id"
    t.integer "professional_id"
    t.integer "set_function_id"
    t.text    "observation",     limit: 65535
    t.index ["filmable_type", "filmable_id"], name: "index_filmable_professionals_on_filmable_type_and_filmable_id", using: :btree
    t.index ["professional_id"], name: "index_filmable_professionals_on_professional_id", using: :btree
    t.index ["set_function_id"], name: "index_filmable_professionals_on_set_function_id", using: :btree
  end

  create_table "movies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "original_title"
    t.string   "title"
    t.integer  "year"
    t.string   "length"
    t.text     "synopsis",          limit: 65535
    t.date     "release"
    t.date     "brazilian_release"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "age_range_id"
    t.string   "cover"
    t.integer  "studio_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "professionals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "gender"
    t.string   "nickname"
    t.date     "birthday"
    t.integer  "age"
    t.string   "cep"
    t.string   "address"
    t.string   "number"
    t.string   "neighbourhood"
    t.string   "complement"
    t.string   "cpf"
    t.string   "phone"
    t.string   "mobile"
    t.string   "avatar"
    t.text     "biography",       limit: 65535
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "set_function_id"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["city_id"], name: "index_professionals_on_city_id", using: :btree
    t.index ["country_id"], name: "index_professionals_on_country_id", using: :btree
    t.index ["state_id"], name: "index_professionals_on_state_id", using: :btree
  end

  create_table "series", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "original_title"
    t.string   "title"
    t.integer  "year"
    t.string   "length"
    t.text     "synopsis",          limit: 65535
    t.date     "release"
    t.date     "brazilian_release"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "age_range_id"
    t.string   "cover"
    t.integer  "studio_id"
    t.integer  "season"
    t.integer  "number_episodes"
    t.integer  "aired_episodes"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "set_functions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_set_functions_on_user_id", using: :btree
  end

  create_table "states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "acronym"
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id", using: :btree
  end

  create_table "studios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "country_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                default: "",    null: false
    t.string   "encrypted_password",                   default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.integer  "gender"
    t.string   "nickname"
    t.date     "birthday"
    t.integer  "age"
    t.string   "cep"
    t.string   "address"
    t.string   "number"
    t.string   "neighbourhood"
    t.string   "complement"
    t.integer  "role"
    t.string   "cpf"
    t.string   "phone"
    t.string   "mobile"
    t.string   "avatar"
    t.text     "biography",              limit: 65535
    t.boolean  "terms_of_use",                         default: false
    t.boolean  "accepted_term_of_use"
    t.date     "registered_at"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["city_id"], name: "index_users_on_city_id", using: :btree
    t.index ["country_id"], name: "index_users_on_country_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["state_id"], name: "index_users_on_state_id", using: :btree
  end

  add_foreign_key "set_functions", "users"
end
