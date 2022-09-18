Rails.application.routes.draw do

  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  # ユーザー用
  # URL /users/sign_in
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # ゲスト用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # 管理者用
  # URL /admin/sign_in
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
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
    resources :users do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end
    resources :books do
      resources :reviews do
        resource :favorites, only: [:create, :destroy]
      end
    end
end
end
