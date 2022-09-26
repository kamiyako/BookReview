class Review < ApplicationRecord
  belongs_to :user

  # ブックのプライマリキーをisbnにする
  belongs_to :book, primary_key: "isbn"
  # タグ検索
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags# through(Review.tagsとすればReviewに紐付けられたTagの取得が可能になるオプション)
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :star, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
# createアクションで記述したsave_tagインスタンスメソッドの中身を定義する
  def save_tag(sent_tags)
    # @reviewに紐付いているタグが存在する場合全てのデータを取得する

    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 取得した@reviewに存在するタグから、送信されてきたタグを除いたタグ
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから、現在存在するタグを除いたタグ
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      # 古いタグを削除
     self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      # 新しいタグを保存
     new_review_tag = Tag.find_or_create_by(tag_name: new)
     self.tags << new_review_tag
    end
  end
end
