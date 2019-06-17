Rails.application.routes.draw do
  devise_for :users
  get 'users', to: 'users#index'
  get 'profile/:id', to: 'users#show', as: 'profile'
  get 'timeline', to: 'posts#index'
  get 'friend_requests', to: 'friend_requests#index'
  get 'friends', to: 'friend_requests#friends'
  resource :posts, only: [:new, :create, :destroy]
  resource :likes, only: [:create, :destroy]
  resource :comments, only: [:new, :create, :destroy]
end
