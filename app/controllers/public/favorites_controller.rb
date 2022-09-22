class Public::FavoritesController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    favorite = current_user.favorites.new(review_id: review.id)
    favorite.save
    redirect_to new_public_book_review_path(params[:book_id])
  end

  def destroy
    review = Review.find(params[:review_id])
    favorite = current_user.favorites.find_by(review_id: review.id)
    favorite.destroy
    redirect_to new_public_book_review_path(params[:book_id])
  end

  private

  def favorited_params
    @review = Review.find(params[:review_id])
  end

end
