class Admin::UsersController < ApplicationController

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to request.referer
  end

end
