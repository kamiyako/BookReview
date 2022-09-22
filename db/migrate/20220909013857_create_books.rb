class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books, id: false do |t| #id: false自動で主キーをIDにする設定を解除
      
      t.string :title, null: false
      t.string :author, null: false
      # 商品判別のためのバーコード=ISBNコード（JANコード）
      t.bigint :isbn, null: false, primary_key: true
      t.string :url, null: false
      t.string :image_url, null: false
      t.string :item_caption, null: false

      t.timestamps
    end
  end
end
