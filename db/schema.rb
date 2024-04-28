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

ActiveRecord::Schema.define(version: 2020_04_08_064712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "endings", force: :cascade do |t|
    t.bigint "survey_id"
    t.string "headline"
    t.string "subheadline"
    t.boolean "include_sharing", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_endings_on_survey_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "survey_id"
    t.string "headline"
    t.string "subheadline"
    t.boolean "ask_for_testing", default: true
    t.string "ask_for_testing_label"
    t.string "ask_for_testing_options"
    t.boolean "ask_for_email", default: true
    t.string "ask_for_email_label"
    t.boolean "open_ended_question", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_feedbacks_on_survey_id"
  end

  create_table "introductions", force: :cascade do |t|
    t.bigint "survey_id"
    t.string "headline"
    t.string "subheadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_introductions_on_survey_id"
  end

  create_table "market_segments", force: :cascade do |t|
    t.bigint "survey_id"
    t.string "headline"
    t.string "subheadline"
    t.jsonb "segment_questions", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_scale", default: 0
    t.integer "max_scale", default: 1
    t.string "lowest_value_label"
    t.string "highest_value_label"
    t.boolean "open_ended_question", default: false
    t.index ["survey_id"], name: "index_market_segments_on_survey_id"
  end

  create_table "problem_statements", force: :cascade do |t|
    t.bigint "survey_id"
    t.string "headline"
    t.string "subheadline"
    t.jsonb "problem_segments", default: {}
    t.boolean "open_ended_question", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_scale", default: 0
    t.integer "max_scale", default: 1
    t.string "lowest_value_label"
    t.string "highest_value_label"
    t.index ["survey_id"], name: "index_problem_statements_on_survey_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.bigint "workspace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_projects_on_workspace_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "survey_id"
    t.jsonb "market_segment_answers", default: {}
    t.string "market_segment_open_answer", limit: 256
    t.datetime "survey_completed_at"
    t.string "user_token", limit: 128
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "problem_statement_answers", default: {}
    t.string "problem_statement_open_answer", limit: 256
    t.jsonb "solution_statement_answers", default: {}
    t.string "solution_statement_open_answer", limit: 256
    t.integer "step", default: 1
    t.jsonb "feedback_answers", default: {}
    t.string "feedback_email", limit: 128
    t.string "feedback_open_answer", limit: 256
    t.index ["survey_id"], name: "index_results_on_survey_id"
  end

  create_table "shortened_urls", id: :serial, force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type", limit: 20
    t.text "url", null: false
    t.string "unique_key", limit: 10, null: false
    t.string "category"
    t.integer "use_count", default: 0, null: false
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category"], name: "index_shortened_urls_on_category"
    t.index ["owner_id", "owner_type"], name: "index_shortened_urls_on_owner_id_and_owner_type"
    t.index ["unique_key"], name: "index_shortened_urls_on_unique_key", unique: true
    t.index ["url"], name: "index_shortened_urls_on_url"
  end

  create_table "solution_statements", force: :cascade do |t|
    t.bigint "survey_id"
    t.string "headline"
    t.string "subheadline"
    t.jsonb "solution_segments", default: {}
    t.integer "min_scale", default: 0
    t.integer "max_scale", default: 5
    t.string "lowest_value_label"
    t.string "highest_value_label"
    t.boolean "open_ended_question", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_solution_statements_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_surveys_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.citext "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "last_name", limit: 128
    t.string "first_name", limit: 128
    t.boolean "admin"
    t.integer "status", default: 0
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "workspace_members", force: :cascade do |t|
    t.bigint "workspace_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "creator", default: false
    t.index ["user_id"], name: "index_workspace_members_on_user_id"
    t.index ["workspace_id"], name: "index_workspace_members_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "endings", "surveys"
  add_foreign_key "feedbacks", "surveys"
  add_foreign_key "introductions", "surveys"
  add_foreign_key "market_segments", "surveys"
  add_foreign_key "problem_statements", "surveys"
  add_foreign_key "projects", "workspaces"
  add_foreign_key "results", "surveys"
  add_foreign_key "solution_statements", "surveys"
  add_foreign_key "surveys", "projects"
  add_foreign_key "workspace_members", "users"
  add_foreign_key "workspace_members", "workspaces"
end
