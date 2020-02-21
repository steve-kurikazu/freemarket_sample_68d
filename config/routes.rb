Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  #root "sendings#create"
  resources :items, only: [:new, :create]
  resources :sendings, only: [:new, :create, :edit]
  resources :users, only: [:show]
end