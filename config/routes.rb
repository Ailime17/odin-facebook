Rails.application.routes.draw do
  devise_for :users

  root 'users#show'

  resources :users, only: :show do
    resources :friend_requests, only: [:create]
    constraints ConstraintForNewPost.new do
      resources :posts, only: [:new, :create]
    end
  end
  resources :posts, only: [:destroy, :show] do
    resources :likes, only: [:create]
    resources :comments, only: [:create]
  end
  resources :friend_requests, only: [:update, :destroy]
  resources :likes, only: [:destroy]
  resources :comments, only: [:destroy]
end
