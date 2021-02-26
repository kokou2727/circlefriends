Rails.application.routes.draw do
  devise_for :users

  get 'posts/index'
  get 'users/add_user_to_group'
  root to: "posts#index"
  resources :posts, only: [:index, :create]
  resources :users, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]
  resources :group_users, only: :destroy
  resources :groups, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :chats, only: [:index, :create, :destroy]
  end
end
