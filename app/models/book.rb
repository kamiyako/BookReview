class Book < ApplicationRecord
  # bookのプライマリキーをisbnにする
  self.primary_key = "isbn"
  has_many :reviews, dependent: :destroy
  # タグ検索
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags# through(Book.tagsとすればBookに紐付けられたTagの取得が可能になるオプション)
end
