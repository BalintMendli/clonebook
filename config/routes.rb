Rails.application.routes.draw do
  devise_for :users
  get 'profile', to: 'users#show'
  get 'timeline', to: 'posts#index'
  resource :posts, only: [:new, :create, :destroy]
end
