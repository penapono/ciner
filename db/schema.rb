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

ActiveRecord::Schema.define(version: 20170424052439) do

  create_table "age_ranges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "broadcast_broadcastables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "broadcastable_type"
    t.integer  "broadcastable_id"
    t.integer  "broadcast_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "broadcasts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content",        limit: 65535
    t.boolean  "spoiler",                      default: false
    t.boolean  "featured",                     default: false
    t.integer  "likes_count",                  default: 0
    t.integer  "dislikes_count",               default: 0
    t.integer  "comments_count",               default: 0
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["user_id"], name: "index_broadcasts_on_user_id", using: :btree
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

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.text     "content",          limit: 65535
    t.integer  "status",                         default: 1
    t.integer  "origin",                         default: 2
    t.boolean  "spoiler",                        default: false
    t.boolean  "featured",                       default: false
    t.integer  "likes_count",                    default: 0
    t.integer  "dislikes_count",                 default: 0
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
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
    t.integer  "rating"
    t.integer  "filmable_release_year"
    t.integer  "status",                              default: 1
    t.integer  "origin",                              default: 2
    t.boolean  "spoiler",                             default: false
    t.boolean  "featured",                            default: false
    t.boolean  "quick",                               default: false
    t.integer  "likes_count",                         default: 0
    t.integer  "dislikes_count",                      default: 0
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["filmable_type", "filmable_id"], name: "index_critics_on_filmable_type_and_filmable_id", using: :btree
    t.index ["user_id"], name: "index_critics_on_user_id", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.date     "event_date"
    t.time     "start_time"
    t.time     "end_time"
    t.text     "description", limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "featured",                  default: false
  end

  create_table "film_production_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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

  create_table "filmable_type", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "filmable_type"
    t.integer "filmable_id"
    t.integer "film_production_categories_id"
    t.index ["film_production_categories_id"], name: "index_filmable_type_on_film_production_categories_id", using: :btree
    t.index ["filmable_type", "filmable_id"], name: "index_filmable_type_on_filmable_type_and_filmable_id", using: :btree
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
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.text     "omdb_directors",    limit: 65535
    t.text     "omdb_writers",      limit: 65535
    t.text     "omdb_actors",       limit: 65535
    t.text     "omdb_genre",        limit: 65535
    t.text     "omdb_rated",        limit: 65535
    t.text     "omdb_id",           limit: 65535
    t.text     "omdb_trailer",      limit: 65535
    t.text     "trailer",           limit: 65535
    t.integer  "tmdb_id"
    t.boolean  "playing",                         default: false
    t.integer  "user_id"
    t.boolean  "lock_updates",                    default: false
    t.string   "countries"
    t.index ["user_id"], name: "index_movies_on_user_id", using: :btree
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
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "tmdb_id"
    t.date     "deathday"
    t.integer  "imdb_id"
    t.string   "place_of_birth"
    t.boolean  "lock_updates",                  default: false
    t.index ["city_id"], name: "index_professionals_on_city_id", using: :btree
    t.index ["country_id"], name: "index_professionals_on_country_id", using: :btree
    t.index ["state_id"], name: "index_professionals_on_state_id", using: :btree
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "questionable_type"
    t.integer  "questionable_id"
    t.string   "title"
    t.text     "content",           limit: 65535
    t.integer  "status",                          default: 1
    t.integer  "origin",                          default: 2
    t.boolean  "spoiler",                         default: false
    t.boolean  "featured",                        default: false
    t.integer  "likes_count",                     default: 0
    t.integer  "dislikes_count",                  default: 0
    t.integer  "comments_count",                  default: 0
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["questionable_type", "questionable_id"], name: "index_questions_on_questionable_type_and_questionable_id", using: :btree
    t.index ["user_id"], name: "index_questions_on_user_id", using: :btree
  end

  create_table "serie_episodes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "series_id"
    t.string   "original_title_ep"
    t.string   "title_ep"
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
    t.integer  "episode_number"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["age_range_id"], name: "index_serie_episodes_on_age_range_id", using: :btree
    t.index ["city_id"], name: "index_serie_episodes_on_city_id", using: :btree
    t.index ["country_id"], name: "index_serie_episodes_on_country_id", using: :btree
    t.index ["series_id"], name: "index_serie_episodes_on_series_id", using: :btree
    t.index ["state_id"], name: "index_serie_episodes_on_state_id", using: :btree
    t.index ["studio_id"], name: "index_serie_episodes_on_studio_id", using: :btree
  end

  create_table "serie_season_episodes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "serie_id"
    t.integer  "serie_season_id"
    t.date     "air_date"
    t.integer  "episode_number"
    t.string   "name"
    t.text     "overview",        limit: 65535
    t.integer  "tmdb_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["serie_id"], name: "index_serie_season_episodes_on_serie_id", using: :btree
    t.index ["serie_season_id"], name: "index_serie_season_episodes_on_serie_season_id", using: :btree
  end

  create_table "serie_seasons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "serie_id"
    t.string   "name"
    t.text     "overview",           limit: 65535
    t.date     "air_date"
    t.integer  "tmdb_id"
    t.string   "poster"
    t.integer  "season_number"
    t.integer  "number_of_episodes",               default: 0
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["serie_id"], name: "index_serie_seasons_on_serie_id", using: :btree
  end

  create_table "series", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "original_title"
    t.string   "title"
    t.integer  "start_year"
    t.integer  "finish_year"
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
    t.integer  "number_episodes"
    t.integer  "aired_episodes"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.text     "omdb_directors",    limit: 65535
    t.text     "omdb_writers",      limit: 65535
    t.text     "omdb_actors",       limit: 65535
    t.text     "omdb_genre",        limit: 65535
    t.text     "omdb_rated",        limit: 65535
    t.text     "omdb_id",           limit: 65535
    t.text     "omdb_trailer",      limit: 65535
    t.text     "trailer",           limit: 65535
    t.integer  "tmdb_id"
    t.integer  "number_of_seasons",               default: 1
    t.boolean  "playing",                         default: false
    t.integer  "user_id"
    t.boolean  "lock_updates",                    default: false
    t.string   "countries"
    t.index ["user_id"], name: "index_series_on_user_id", using: :btree
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

  create_table "user_filmables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "filmable_type"
    t.integer  "filmable_id"
    t.integer  "action"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "media"
    t.integer  "version"
    t.index ["filmable_type", "filmable_id"], name: "index_user_filmables_on_filmable_type_and_filmable_id", using: :btree
    t.index ["user_id"], name: "index_user_filmables_on_user_id", using: :btree
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

  create_table "visits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "controller"
    t.string   "action"
    t.string   "path"
    t.integer  "resource_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_visits_on_user_id", using: :btree
  end

  create_table "votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  add_foreign_key "set_functions", "users"
end
