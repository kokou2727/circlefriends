Rails.application.routes.draw do
  devise_for :users

  get '/post/hashtag/:name', to: "posts#hashtag"
  get 'posts/index'
  get 'users/add_user_to_group'
  get 'group_users/participate'
  root to: "posts#index"
  resources :posts, only: [:index, :create] do
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :group_users, only: :destroy
  resources :groups, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    resources :chats, only: [:index, :create, :destroy]
  end
end
