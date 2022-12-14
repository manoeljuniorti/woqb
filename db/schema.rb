# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_07_215029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "account_apps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "tenant"
    t.uuid "client_app_id", null: false
    t.json "quick_books_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_app_id"], name: "index_account_apps_on_client_app_id"
  end

  create_table "client_apps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "public_key"
    t.string "secret_key"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "qbwc_jobs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "company", limit: 1000
    t.string "worker_class", limit: 100
    t.boolean "enabled", default: false, null: false
    t.text "request_index"
    t.text "requests"
    t.boolean "requests_provided_when_job_added", default: false, null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company"], name: "index_qbwc_jobs_on_company"
    t.index ["name"], name: "index_qbwc_jobs_on_name", unique: true
  end

  create_table "qbwc_sessions", id: :serial, force: :cascade do |t|
    t.string "ticket"
    t.string "user"
    t.string "company", limit: 1000
    t.integer "progress", default: 0, null: false
    t.string "current_job"
    t.string "iterator_id"
    t.string "error", limit: 1000
    t.text "pending_jobs", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "account_apps", "client_apps"
end
