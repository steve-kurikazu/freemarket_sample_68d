Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :items, only: [:new, :create]
  resources :sendings, only: [:new, :create]
  resources :users, only: [:show]
  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
  resources :orders, only: [:index] do
    collection do
      get 'index', to: 'orders#index'
      post 'pay', to: 'orders#pay'
      get 'done', to: 'orders#done'
    end
  end
end