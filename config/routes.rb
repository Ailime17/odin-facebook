Rails.application.routes.draw do
  devise_for :users

  root 'users#show'

  resources :users, only: :show do
    constraints TurboFrameConstraint.new do
      resources :friend_requests, except: [:edit, :index]
      resources :posts, only: [:new, :create]
      resource :profile, only: [:show, :edit, :update]
    end
  end

  resources :posts, only: [:destroy, :show, :index] do
    resources :likes, only: [:create]
    constraints TurboFrameConstraint.new do
      resources :comments, only: [:new, :create]
    end
  end

  resources :likes, only: [:destroy]
  resources :comments, only: [:destroy]
end
