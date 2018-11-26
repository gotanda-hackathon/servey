class QuestionDetail < ApplicationRecord
  belongs_to :question
  has_many :question_detail_choices
  has_many :question_prices
  has_many :answer_details

  enum :type {
    single_choice: 1,
    multiple_choice: 2,
    long_description: 3,
    short_description: 4,
    date: 5,
    date_time: 6
  }
end
