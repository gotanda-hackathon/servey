class AnswerDetail < ApplicationRecord
  belongs_to :answer
  belongs_to :question_detail
  has_many :answer_detail_contents
end
