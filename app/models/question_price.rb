class QuestionPrice < ApplicationRecord
  belongs_to :question
  belongs_to :question_detail, optional: true
  belongs_to :question_section, optional: true

  enum :type {
    question_detail: 1,
    section: 2,
    fixed: 3
  }
end
