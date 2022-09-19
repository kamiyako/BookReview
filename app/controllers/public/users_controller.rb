class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end


end
