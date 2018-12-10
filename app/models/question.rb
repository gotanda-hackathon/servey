class Question < ApplicationRecord
  belongs_to :user_id
  has_many :question_details
  has_many :question_categories
  has_many :question_sections
  has_many :question_price
  has_many :answers
end
