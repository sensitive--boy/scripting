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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120530090401) do

  create_table "addresses", :force => true do |t|
    t.string   "venue"
    t.string   "addition"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "zip"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "addresses", ["person_id"], :name => "index_addresses_on_person_id"

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "audiotracks", :force => true do |t|
    t.string   "interpreter"
    t.string   "album"
    t.string   "title"
    t.integer  "fraction_length"
    t.integer  "szene_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "audiotracks", ["szene_id"], :name => "index_audiotracks_on_szene_id"

  create_table "characters", :force => true do |t|
    t.string   "charactername"
    t.integer  "treatment_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "characters", ["treatment_id"], :name => "index_characters_on_treatment_id"

  create_table "media_files", :force => true do |t|
    t.string   "description"
    t.string   "origin"
    t.integer  "szene_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "media_files", ["szene_id"], :name => "index_media_files_on_szene_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "firstname"
    t.string   "email"
    t.string   "phone"
    t.string   "mobile"
    t.string   "messenger"
    t.integer  "user_id"
    t.integer  "admin_id"
    t.integer  "video_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "people", ["admin_id"], :name => "index_people_on_admin_id"
  add_index "people", ["user_id"], :name => "index_people_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "role"
    t.integer  "show_id"
    t.integer  "video_id_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "roles", ["video_id_id"], :name => "index_roles_on_video_id_id"

  create_table "sequences", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "video_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sequences", ["video_id"], :name => "index_sequences_on_video_id"

  create_table "shows", :force => true do |t|
    t.datetime "date"
    t.string   "title"
    t.string   "toppic"
    t.integer  "duration"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "shows", ["user_id"], :name => "index_shows_on_user_id"

  create_table "szenes", :force => true do |t|
    t.string   "place"
    t.text     "description"
    t.string   "title"
    t.integer  "position"
    t.integer  "sequence_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "szenes", ["sequence_id"], :name => "index_szenes_on_sequence_id"

  create_table "takes", :force => true do |t|
    t.text     "view_desc"
    t.text     "audio_desc"
    t.integer  "duration"
    t.integer  "position"
    t.string   "note"
    t.integer  "szene_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "takes", ["szene_id"], :name => "index_takes_on_szene_id"

  create_table "treatments", :force => true do |t|
    t.text     "text"
    t.string   "main_characteristc"
    t.string   "conflict"
    t.string   "development"
    t.string   "storyline"
    t.string   "place"
    t.text     "first_szene_desc"
    t.string   "moral"
    t.string   "keywords"
    t.integer  "video_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "treatments", ["video_id"], :name => "index_treatments_on_video_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "username"
    t.boolean  "advisor",                :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.string   "format"
    t.integer  "supposed_duration"
    t.integer  "duration"
    t.text     "summary"
    t.integer  "show_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "user_id"
  end

end
