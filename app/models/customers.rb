class Customer < ApplicationRecord
  belongs_to :business_category
  belongs_to :business_category_detail
  has_many :answers

  include JpPrefecture
  jp_prefecture :prefecture_code

  enum :gender {

  }
end
