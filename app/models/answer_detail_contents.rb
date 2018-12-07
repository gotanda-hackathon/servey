class AnswerDetailContent < ApplicationRecord
  belongs_to :answer_detail
  belongs_to :question_detail_choice, optional: true
end
