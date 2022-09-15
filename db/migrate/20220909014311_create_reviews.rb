class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews, id: false do |t|#id: falseで自動で主キーをIDにする設定を解除
      # 星レビュー（細かい評価ができるfloat型）
      t.float :star, null: false, default: 0
      t.string :title
      t.string :body
      # 既存のテーブルを指定
      t.references :book, null: false
      # user_idという名前で users.id への外部キー制約をはる
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
    # 指定したテーブルに外部キー制約を追加add_foreign_key(参照元テーブル名, 参照先テーブル名, オプション引数)
    add_foreign_key :reviews, :books, column: :book_id , primary_key: :isbn
  end
end
