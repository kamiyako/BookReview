class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url
  before_action :authenticate_user!, if: :public_url

  def admin_url
    request.fullpath.include?("/admin")
  end

  def public_url
    request.path.include?("/public")
  end


    # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    if resource.is_a?(Admin)
      admin_root_path
    else
      public_books_path
    end
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end

end
