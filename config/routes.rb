Rails.application.routes.draw do

  # ユーザー用
  # URL /users/sign_in
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  get 'books/search', to: "public/books#search"

  namespace :admin do
    root to: "homes#top"
    resources :reviews
    resources :genres
  end

  namespace :public do
    resources :users
    resources :books do
      resources :reviews
    end
end
end
