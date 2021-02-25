Rails.application.routes.draw do
  devise_for :users

  get 'posts/index'
  root to: "posts#index"
  resources :posts, only: [:index, :create]
  resources :users, only: [:show, :destroy]
  resources :relationships, only: :create
  resources :group_users, only: :destroy
  resources :groups, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :chats, only: [:index, :create, :destroy]
  end
end
