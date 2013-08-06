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

ActiveRecord::Schema.define(:version => 20130806144009) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.boolean  "repeating"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "old_id"
    t.integer  "user_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "events", :force => true do |t|
    t.integer  "activity_id"
    t.string   "google_event_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "name"
    t.integer  "location_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "goals", :force => true do |t|
    t.float    "total_hours"
    t.float    "hours_remaining"
    t.integer  "activity_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "locations", :force => true do |t|
    t.integer  "activity_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tasks", :force => true do |t|
    t.datetime "day"
    t.boolean  "complete"
    t.float    "number_of_hours"
    t.integer  "category_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "weekly_plans", :force => true do |t|
    t.datetime "start_date"
    t.float    "number_of_hours"
    t.integer  "activity_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "windows", :force => true do |t|
    t.integer  "activity_id"
    t.float    "end_time"
    t.float    "begin_time"
    t.integer  "day_of_week"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
