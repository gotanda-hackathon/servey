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

ActiveRecord::Schema.define(version: 2018_12_11_002232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answer_detail_contents", force: :cascade do |t|
    t.bigint "answer_detail_id", null: false
    t.bigint "question_detail_choice_id"
    t.text "long_description"
    t.string "short_description"
    t.date "date"
    t.datetime "date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answer_details", force: :cascade do |t|
    t.integer "answer_id", null: false
    t.bigint "question_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "customer_id", null: false
    t.integer "earned_money"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.integer "business_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.integer "business_category_id"
    t.integer "business_category_detail_id"
    t.integer "prefecture_code"
    t.integer "gender"
    t.integer "age"
    t.date "birthday"
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "question_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_detail_choices", force: :cascade do |t|
    t.bigint "question_detail_id", null: false
    t.bigint "next_question_detail_id"
    t.string "content", null: false
    t.boolean "finish", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_details", force: :cascade do |t|
    t.bigint "question_section_id", null: false
    t.string "title", null: false
    t.string "explanation"
    t.integer "type", null: false
    t.boolean "required", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_prices", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "question_detail_id"
    t.bigint "question_section_id"
    t.integer "price", null: false
    t.integer "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_sections", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "name", null: false
    t.string "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.string "explanation"
    t.integer "min_required_customer_qty", null: false
    t.integer "max_required_customer_qty", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "company_id", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
