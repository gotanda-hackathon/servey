class Company < ApplicationRecord
  has_many :customers
  has_one :business_category
end
