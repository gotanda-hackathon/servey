class QuestionDetail < ApplicationRecord
  belongs_to :question_section
  has_many :question_detail_choices
  has_many :question_prices
  has_many :answer_details

  accepts_nested_attributes_for :question_detail_choices, allow_destroy: true

  self.inheritance_column = :_type_disabled

  enum type: {
    single_choice: 1,
    # multiple_choice: 2,
    # long_description: 3,
    short_description: 4,
    # date: 5,
    # date_time: 6
  }

  class << self
    def permit_params
      super + [
          question_detail_choices_attributes: QuestionDetailChoice.permit_params
      ]
    end
  end
end
