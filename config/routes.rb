Rails.application.routes.draw do
  devise_for :users
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "posts#index"
  resources :users, only: [:show, :edit, :update] do
    resources :follows, only: [:create, :destroy]
  end

  resources :posts do
    collection do
      get :nearby
      get :following
    end
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  delete "posts/:id", to: "posts#destroy", as: :delete_post
end
