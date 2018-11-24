class Company < ApplicationRecord
  has_many :users
  has_one :business_category
end
