class CreateGoogleHomeConversation < ActiveRecord::Migration[5.2]
  def up
    create_table "google_home_conversations", force: :cascade do |t|
      t.string   "conversation_id",  default: "", null: false, comment: 'カテゴリ名'
      t.integer  "customer_id",          default: 0,  null: false
      t.integer  "login",          default: 0,  null: false
      t.string  "login_code",          default: 0,  null: false
      t.integer  "mode",          default: 0,  null: false
      t.integer  "question_detail_id",   default: 0,  null: false
      t.datetime "deleted_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
