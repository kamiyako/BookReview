class Public::ReviewsController < ApplicationController

 def create
   # 同じユーザーが連投したときは更新するようにする
  review = current_user.reviews.find_by(book_id: params[:review][:book_id])
  if review
     params[:id] = review.id
     params[:book_id] = review.book_id
     update
  else
    @review = current_user.reviews.new(review_params)
    # formから、@reviewオブジェクトを参照してタグの名前も一緒に送信する。
    # splitで、["タグ" "検索" "機能"]でスペースで区切り配列化する。
    tag_list = params[:review][:tag_name].split(nil)
    if @review.save
      # tag_listで取得したデータを保存する
      @review.save_tag(tag_list)
      #コメント送信後は、一つ前のページへリダイレクトさせる。
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end
 end


  def new
    @book = Book.find(params[:book_id])
    @reviews = @book.reviews
    # 同じユーザーが連投できないようにする
    review = current_user.reviews.find_by(book_id: @book.id)
    if review
      @review = review
    else
      @review = current_user.reviews.new
    end

    # クリックした投稿に紐付けられているタグの取得。
    @review_tags = @review.tags
  end

  def index
    @reviews = Review.all
    @tag_list = Tag.all
  end

  def edit
    @review = Review.find(params[:id])
    @tag_list=@review.tags.pluck(:tag_name).join(nil)
  end


  def update
    @book = Book.find(params[:book_id])
    review = Review.find(params[:id])
    # tagの編集&削除
    tag_list = params[:review][:tag_name].split(nil)
    # もしreviewの情報が更新されたら
    if review.update(review_params)
      # このreview_idに紐づいていたタグを@oldに入れる
      old_relations = BookTag.where(review_id: review.id)
      # それらを取り出し、消す。
      old_relations.each do |relation|
        relation.delete
      end
      review.save_tag(tag_list)
      redirect_to new_public_book_review_path(@book.id), notice:'投稿完了しました:)'
    else
      redirect_to :action => "edit"
    end
  end


  def destroy
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to request.referer
  end

  def search
    @tag_list = Tag.all               #タグを全取得
    @tag = Tag.find(params[:tag_id])  # クリックしたタグを取得
    @reviews = @tag.reviews.all       # クリックしたタグに紐付けられた投稿を全て表示
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :star, :book_id, :user_id )
  end

end
