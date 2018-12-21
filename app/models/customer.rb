class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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
