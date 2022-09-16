class Public::UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @reviews = User.reviews.all
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

  
end
