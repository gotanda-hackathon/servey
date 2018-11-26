class User < ApplicationRecord
  belongs_to :company
  has_many :questions
end
