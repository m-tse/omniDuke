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

ActiveRecord::Schema.define(:version => 20120803043359) do

  create_table "areas_of_knowledges", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "areas_of_knowledges_courses", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "areas_of_knowledge_id"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "course_description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.decimal  "credits"
    t.integer  "old_number"
    t.integer  "new_number"
    t.string   "location"
    t.integer  "session_id"
  end

  create_table "courses_modes_of_inquiries", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "modes_of_inquiry_id"
  end

  create_table "courses_subjects", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "subject_id"
  end

  create_table "instructors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "modes_of_inquiries", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "prerequisite_relations", :force => true do |t|
    t.integer  "course_id"
    t.integer  "prerequisite_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "name"
    t.integer  "year"
    t.string   "season"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
