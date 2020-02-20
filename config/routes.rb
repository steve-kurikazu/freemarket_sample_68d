Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :items, only: [:new, :create, :show]
  resources :sendings, only: [:new, :create]
  resources :users, only: [:show]
end