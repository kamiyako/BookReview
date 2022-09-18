class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def destroy
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @reviews.destroy
    redirect_to request.referer
  end
end
