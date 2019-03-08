class Customer < ApplicationRecord
  belongs_to :business_category
  belongs_to :business_category_detail
  has_many :answers

  include JpPrefecture
  jp_prefecture :prefecture_code

  enum gender: {
    male: 1,
    female: 2,
    not_set: 0,
    other: 9
  }
end
