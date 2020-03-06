Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :sendings, only: [:new, :create, :edit, :update]
  resources :users, only: [:edit, :update]
  resources :cards, only: [:new, :create, :destroy]
  resources :profiles, only: [:create, :update]
  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
    end
    resources :orders, only: [:new] do
      collection do
        post 'pay', to: 'orders#pay'
      end
    end
  end

  get 'items/:id/get_category_children', to: 'items#get_category_children'
  get 'items/:id/get_category_grandchildren', to: 'items#get_category_grandchildren'
end
