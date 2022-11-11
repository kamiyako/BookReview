class Public::UsersController < ApplicationController
  before_action :set_user, :only => [:show, :index, :destroy]
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def index
    @likes = current_user.favorites
  end

  # def destroy
  #   @review = Review.find(params[:id])
  #   @review.destroy
  # end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to :root
  end

  private

  def set_user
    @user = User.find_by(:id => params[:id])
  end

end
