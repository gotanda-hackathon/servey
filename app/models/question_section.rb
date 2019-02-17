class QuestionSection < ApplicationRecord
  belongs_to :question
  has_many :question_details

  accepts_nested_attributes_for :question_details, allow_destroy: true

  class << self
    def permit_params
      super + [
          question_details_attributes: QuestionDetail.permit_params
      ]
    end
  end
end
