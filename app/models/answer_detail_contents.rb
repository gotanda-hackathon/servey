class AnswerDetailContent < ApplicationRecord
  belongs_to :answer_detail
  belongs_to :question_detail_choice, optional: true

  enum :type {
    question_detail: 1,
    section: 2,
    fixed: 3
  }
end
