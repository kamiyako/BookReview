class Review < ApplicationRecord
  belongs_to :user
  # ブックのプライマリキーをisbnにする
  belongs_to :book, primary_key: "isbn"
end
