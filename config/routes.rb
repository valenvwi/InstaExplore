Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :users, only: %i[show edit update] do
    resources :follows, only: %i[create destroy] do
      collection do
        get :followings
        get :followers
      end
    end
  end

  get "users/:id/notifications", to: "users#notification", as: :notification

  resources :posts do
    collection do
      get :nearby
      get :following
      get :search
    end
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end

  delete "posts/:id", to: "posts#destroy", as: :delete_post

  post "chatrooms/:id", to: "chatrooms#create", as: :create_chatroom
  resources :chatrooms, only: %i[index show] do
    resources :messages, only: :create
  end
end
