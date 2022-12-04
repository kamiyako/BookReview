class Public::UsersController < ApplicationController
  before_action :set_user, :only => [:show, :index, :destroy]
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def index
    @likes = current_user.favorites
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "User info was successfully updated."
    redirect_to public_user_path(@user.id)
    else
    render :edit
    end
  end

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

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
