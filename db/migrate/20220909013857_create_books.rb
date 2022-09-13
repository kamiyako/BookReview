class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books, id: false do |t| #id: false自動で主キーをIDにする設定を解除
      
      t.string :title
      t.string :author
      # 商品判別のためのバーコード=ISBNコード（JANコード）
      t.bigint :isbn, null: false, primary_key: true
      t.string :url
      t.string :image_url
      t.string :item_caption
      # 年代別ジャンル用
      t.integer :genre_id
      
      t.timestamps
    end
  end
end
