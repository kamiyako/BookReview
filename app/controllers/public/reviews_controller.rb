class Public::ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      #コメント送信後は、一つ前のページへリダイレクトさせる。
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def new
    @book = Book.find(params[:book_id])
    @reviews = @book.reviews
    @review = current_user.reviews.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @book = Book.find(params[:book_id])
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to public_review_path(@book.id), notice: 'レビューを更新しました'
  end

  def destroy
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to request.referer
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :star, :book_id, :user_id )
  end

end
