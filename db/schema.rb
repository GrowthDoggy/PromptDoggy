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

ActiveRecord::Schema[7.0].define(version: 2024_08_17_025944) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "bearer_type", null: false
    t.bigint "bearer_id", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bearer_type", "bearer_id"], name: "index_api_keys_on_bearer"
    t.index ["token"], name: "index_api_keys_on_token", unique: true
  end

  create_table "deployments", force: :cascade do |t|
    t.bigint "prompt_id", null: false
    t.bigint "environment_id", null: false
    t.boolean "is_static", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["environment_id"], name: "index_deployments_on_environment_id"
    t.index ["prompt_id"], name: "index_deployments_on_prompt_id"
  end

  create_table "environments", force: :cascade do |t|
    t.string "name", null: false
    t.string "token", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_environments_on_project_id"
    t.index ["token"], name: "index_environments_on_token", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.string "token", null: false
    t.string "projectable_type", null: false
    t.bigint "projectable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["projectable_type", "projectable_id"], name: "index_projects_on_projectable"
    t.index ["token"], name: "index_projects_on_token", unique: true
  end

  create_table "prompts", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_prompts_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "deployments", "environments"
  add_foreign_key "deployments", "prompts"
  add_foreign_key "environments", "projects"
  add_foreign_key "prompts", "projects"
end
