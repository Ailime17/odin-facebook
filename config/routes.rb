Rails.application.routes.draw do
  devise_for :users

  root 'users#show'

  resources :users, only: :show do
    resources :friend_requests, only: [:create]
    resources :posts, only: [:new, :create]
  end
  resources :posts, only: [:destroy, :show] do
    resources :likes, only: [:create]
    resources :comments, only: [:create]
  end
  resources :friend_requests, only: [:update, :destroy]
  resources :likes, only: [:destroy]
  resources :comments, only: [:destroy]
end
