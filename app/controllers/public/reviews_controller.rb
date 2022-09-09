class Public::ReviewsController < ApplicationController
  
  def index
  end
  
  def new
    @review = Review.new
  end
  
  def create
    review = Review.new(review_params)
    review.save
    redirect_to review_path(review.id)
  end
  
  def show
    @review = Review.find(params[:id])  
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to review_path(review.id)  
  end
  
  def destroy
    reviews = Review.find(params[:id])
    reviews.destroy
    redirect_to '/reviews'
  end
  
  private
  
  def review_params
    params.require(:review).permit(:title, :body, :star, :book_id, :user_id )
  end
  
end
