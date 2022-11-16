class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :reviews, through: :book_tags
  
  

  # def name_tag(str)
  #   require 'nkf'
  #   str = "アイウエオＡＢＣ０１２"
  #   # nkfライブラリを使用して変換を実行
  #   p NKF.nkf('-w -Z4', str)
  # end
end
