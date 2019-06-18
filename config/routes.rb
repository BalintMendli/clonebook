Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'users', to: 'users#index'
  get 'profile/:id', to: 'users#show', as: 'profile'
  get 'friends', to: 'friend_requests#friends'
  resources :posts, only: [:new, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:new, :create, :destroy]
  resources :friend_requests, only: [:index, :create, :update, :destroy]
end
