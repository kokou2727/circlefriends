Rails.application.routes.draw do
  devise_for :users

  get 'posts/index'
  root to: "posts#index"
  resources :posts, only: [:index, :create]
  resources :users, only: :show
  resources :relationships, only: [:create, :destroy]
  resources :groups, only: [:new, :create, :edit, :update]
end
