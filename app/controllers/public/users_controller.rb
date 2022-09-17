class Public::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end


end
