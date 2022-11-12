class Public::BooksController < ApplicationController

  def index
    # レビューのある本のみ表示させる
    @books = Book.select do |book|
      book.reviews.count > 0
    end
    @tag_list = Tag.all
    # 投稿のコメント数ランキング
    @book_review_ranks = Book.find(Review.group(:book_id).order('count(book_id) desc').pluck(:book_id))
  end

  # /books/search
  def search
    #ここで空の配列を作ります
    @books = []
    @title = params[:title]#タイトル検索
    if @title.present?
      #resultsに楽天APIから取得したデータ(@title)を格納
      results = RakutenWebService::Books::Book.search({
        title: @title,
      })
      #@booksにAPIからの取得したデータを格納
      #privateメソッドから取得
      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
    #@books内の各データをそれぞれ保存
    #unlessで保存済の本は除外する
    @books.each do |book|
      unless Book.all.include?(book)
        book.save
      end
    end
  end

  private
  #楽天APIのデータから必要なデータを絞り込んで対応するカラムにデータを格納するメソッド
  def read(result)
    title = result["title"]
    author = result["author"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    item_caption = result["itemCaption"]
    {
      title: title,
      author: author,
      url: url,
      isbn: isbn,
      image_url: image_url,
      item_caption: item_caption
    }
  end

  def book_params
    params.require(:book).permit(:book_id)
  end


end
