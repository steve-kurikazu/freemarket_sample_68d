Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  
  resources :sendings, only: [:new, :create]
  resources :users, only: [:edit]
  resources :cards, only: [:new, :create, :destroy]

  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do

    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end

  end

  resources :orders, only: [:new] do  
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      post 'pay', to: 'orders#pay'
    end

  end
end