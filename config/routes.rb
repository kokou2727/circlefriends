Rails.application.routes.draw do
  devise_for :users

  get '/post/hashtag/:name', to: "posts#hashtag"
  get 'posts/index'
  get 'users/add_user_to_group'
  get 'group_users/participate'
  get 'group_users/self_participate'
  get 'searches/search_name'
  get 'searches/search_job'
  get 'searches/search_group'
  get 'groups/invite_index'
  get 'relationships/follow_index'
  get 'relationships/follower_index'

  root to: "posts#index"
  resources :posts, only: [:index, :create] do
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :group_users, only: :destroy
  resources :groups do
    resources :chats, only: [:index, :create, :destroy]
  end
  resources :searches,only:[:index]
end
