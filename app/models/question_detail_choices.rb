class QuestionDetailChoice < ApplicationRecord
  belongs_to :question_detail
  belongs_to :next_question_detail, class_name: :QuestionDetail, primary_key: :id, foreign_key: :next_question_detail_id
  has_many :answer_detail_contents
end
