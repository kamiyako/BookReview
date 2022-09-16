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
  # ゲストログイン用
  post 'public/homes/guest_sign_in', to: 'public/homes#guest_sign_in'
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  get 'books/search', to: "public/books#search"

  resources :tags do
    get 'reviews', to: 'public/reviews#search'
  end

  namespace :admin do
    root to: "users#index"
    resources :users
    resources :reviews
  end

  namespace :public do
    resources :users
    resources :books do
      resources :reviews
    end
end
end
