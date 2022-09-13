class Public::ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def create
    @book = Book.find(params[:book_id])
    @review = current_user.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to request.referer
    else
      @book_new = Book.new
      @reviews = @book.reviews
      redirect_to new_public_book_review_path
    end
  end

  def show
    @book = Book.find(params[:book_id])
    @review = Review.new
    @reviews = @book.reviews
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
    @reviews = @book.reviews.all
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
