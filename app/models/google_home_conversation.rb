class GoogleHomeConversation < ApplicationRecord
  belongs_to :customer
  belongs_to :question_detail
end
