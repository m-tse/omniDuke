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

ActiveRecord::Schema.define(:version => 20121225201412) do

  create_table "bookbag_relationships", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "section_id"
  end

  create_table "course_attributes", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "scrape_value"
  end

  create_table "course_attributes_sections", :id => false, :force => true do |t|
    t.integer "course_attribute_id"
    t.integer "section_id"
  end

  create_table "course_numberings", :force => true do |t|
    t.integer  "course_id"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "new_number"
    t.string   "old_number"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "session_id"
    t.string   "old_number"
    t.string   "new_number"
    t.integer  "subject_id"
  end

  create_table "download_relationships", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "note_id"
    t.integer  "user_id"
  end

  create_table "instructors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "instructors", ["name"], :name => "index_instructors_on_name", :unique => true

  create_table "instructors_sections", :id => false, :force => true do |t|
    t.integer "instructor_id"
    t.integer "section_id"
  end

  create_table "note_booked_relationships", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "course_id"
  end

  create_table "note_upload_relationships", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "course_id"
    t.integer  "note_id"
  end

  create_table "notes", :force => true do |t|
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "user_id",    :default => -1, :null => false
    t.string   "file"
    t.integer  "course_id"
  end

  create_table "prerequisite_relations", :force => true do |t|
    t.integer  "course_id"
    t.integer  "prerequisite_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "assignment_easiness"
    t.integer  "test_easiness"
    t.integer  "helpfulness"
    t.integer  "clarity"
    t.integer  "enthusiasm"
    t.integer  "course_content"
    t.integer  "textbook_usefulness"
    t.text     "review_content"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "course_id"
    t.integer  "instructor_id"
  end

  create_table "schedulators", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "schedule_relationships", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "schedulator_id"
    t.integer  "section_id"
  end

  create_table "sections", :force => true do |t|
    t.integer  "course_id"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.integer  "time_slot_id"
    t.integer  "enrollment"
    t.integer  "capacity"
    t.integer  "waitlist_capacity"
    t.integer  "waitlist_enrollment"
    t.integer  "class_number"
    t.text     "description"
    t.text     "synopsis"
    t.string   "name"
    t.string   "list_description"
    t.string   "topic"
    t.string   "campus"
    t.string   "enrollment_requirements"
    t.string   "career"
    t.string   "grading"
    t.string   "location"
    t.decimal  "units",                   :precision => 10, :scale => 0
    t.string   "room"
    t.string   "required_sections"
  end

  create_table "sessions", :force => true do |t|
    t.string   "name"
    t.integer  "year"
    t.string   "season"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["name"], :name => "index_sessions_on_name", :unique => true

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "alias"
  end

  add_index "subjects", ["abbr"], :name => "index_subjects_on_abbr", :unique => true

  create_table "time_periods", :force => true do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "time_slot_id"
    t.integer  "day"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "time_slots", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "aces_value"
  end

  create_table "users", :force => true do |t|
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
    t.integer  "session_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
