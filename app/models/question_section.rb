class QuestionSection < ApplicationRecord
  belongs_to :question
  has_many :question_sections
end
