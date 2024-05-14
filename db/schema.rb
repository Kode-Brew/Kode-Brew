# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_14_215947) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "category"
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "cell_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.string "title", null: false
    t.string "source", null: false
    t.text "video", null: false
    t.text "slide", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.integer "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_members_on_project_id"
    t.index ["user_id"], name: "index_project_members_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "name"
    t.string "category"
    t.string "description"
    t.boolean "is_active?"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "sprint_lectures", force: :cascade do |t|
    t.bigint "sprint_id", null: false
    t.bigint "lecture_id", null: false
    t.bigint "project_member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_id"], name: "index_sprint_lectures_on_lecture_id"
    t.index ["project_member_id"], name: "index_sprint_lectures_on_project_member_id"
    t.index ["sprint_id"], name: "index_sprint_lectures_on_sprint_id"
  end

  create_table "sprints", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.date "date_start"
    t.date "date_end"
    t.string "objective"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_sprints_on_project_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "priority"
    t.string "description"
    t.string "status"
    t.integer "points"
    t.bigint "user_id", null: false
    t.bigint "sprint_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sprint_id"], name: "index_tasks_on_sprint_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "status"
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_tickets_on_task_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "project_members", "projects"
  add_foreign_key "project_members", "users"
  add_foreign_key "projects", "clients"
  add_foreign_key "sprint_lectures", "lectures"
  add_foreign_key "sprint_lectures", "project_members"
  add_foreign_key "sprint_lectures", "sprints"
  add_foreign_key "sprints", "projects"
  add_foreign_key "tasks", "sprints"
  add_foreign_key "tasks", "users"
  add_foreign_key "tickets", "tasks"
  add_foreign_key "tickets", "users"
end
