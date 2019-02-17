class Question < ApplicationRecord
  belongs_to :user
  has_many :question_categories
  has_many :question_sections
  has_many :question_price
  has_many :answers

  accepts_nested_attributes_for :question_sections, allow_destroy: true

  class << self
    def permit_params
      super + [
          question_sections_attributes: QuestionSection.permit_params, question_details_attributes: QuestionDetail.permit_params
      ]
    end
  end
end
