Rails.application.routes.draw do
  devise_for :users

  root 'users#show'

  resources :users, only: :show do
    resources :friend_requests, only: [:create, :update, :destroy]
  end
end
