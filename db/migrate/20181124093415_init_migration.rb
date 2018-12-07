class InitMigration < ActiveRecord::Migration[5.2]
  def up
    create_table "admin_users", force: :cascade do |t|
      t.string "name", null: false
      t.string "email", null: false
      t.string "encrypted_password", default: "", null: false
      t.timestamps
    end
    create_table "users", force: :cascade do |t|
      t.string "name", null: false
      t.bigint "company_id", null: false
      t.string "email", null: false
      t.string "encrypted_password", default: "", null: false
      t.timestamps
    end
    create_table "companies", force: :cascade do |t|
      t.string "name", null: false
      t.integer "business_category_id"
      t.timestamps
    end
    create_table "questions", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.string "title", null: false
      t.string "explanation"
      t.integer "min_required_customer_qty", null: false
      t.integer "max_required_customer_qty", null: false
      t.date "start_date", null: false
      t.date "end_date", null: false
      t.timestamps
    end
    create_table "categories", force: :cascade do |t|
      t.string "name", null: false
      t.timestamps
    end
    create_table "question_categories", force: :cascade do |t|
      t.bigint "category_id", null: false
      t.bigint "question_id", null: false
      t.timestamps
    end
    create_table "question_sections", force: :cascade do |t|
      t.bigint "question_id", null: false
      t.string "name", null: false
      t.string "explanation"
      t.timestamps
    end
    create_table "question_details", force: :cascade do |t|
      t.bigint "question_section_id", null: false
      t.string "title", null: false
      t.string "explanation"
      t.integer "type", null: false
      t.boolean "required", null: false, default: false
      t.timestamps
    end
    create_table "question_detail_choices", force: :cascade do |t|
      t.bigint "question_detail_id", null: false
      t.bigint "next_question_detail_id"
      t.string "content", null: false
      t.boolean "finish", default: false
      t.timestamps
    end
    create_table "question_prices", force: :cascade do |t|
      t.bigint "question_id", null: false
      t.bigint "question_detail_id"
      t.bigint "question_section_id"
      t.integer "price", null: false
      t.integer "type", null: false
      t.timestamps
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
      t.timestamps
    end
    create_table "answers", force: :cascade do |t|
      t.bigint "question_id", null: false
      t.bigint "customer_id", null: false
      t.integer "earned_money"
      t.timestamps
    end
    create_table "answer_details", force: :cascade do |t|
      t.integer "answer_id", null: false
      t.bigint "question_detail_id", null: false
      t.timestamps
    end
    create_table "answer_detail_contents", force: :cascade do |t|
      t.bigint "answer_detail_id", null: false
      t.bigint "question_detail_choice_id"
      t.text "long_description"
      t.string "short_description"
      t.date "date"
      t.datetime "date_time"
      t.timestamps
    end
  end
end
