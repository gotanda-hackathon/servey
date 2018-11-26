class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :customer
  has_many :answer_details
end