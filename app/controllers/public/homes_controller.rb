class Public::HomesController < ApplicationController
  # ゲストログイン
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def top
    # レビューのある本のみ表示させる
    @books = Book.select do |book|
      book.reviews.count > 0
    end
  end

  def about
  end

end
