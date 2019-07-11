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

ActiveRecord::Schema.define(version: 20190711164554) do

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "prefix"
    t.string "course_code"
    t.text "tas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "course_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "course"
    t.string "name"
    t.string "reason"
    t.boolean "being_helped"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "helped_by"
    t.datetime "helped_at"
    t.string "course_id"
    t.string "ta_id"
    t.string "student_id"
    t.datetime "session_end"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "course"
    t.integer "weekly_time"
    t.datetime "clocked_in_time"
    t.string "canvas_id"
    t.string "course_id"
    t.boolean "ta"
    t.integer "weekly_hours"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
