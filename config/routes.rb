Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  
  resources :sendings, only: [:new, :create, :edit, :update]
  resources :users, only: [:edit, :update]
  resources :cards, only: [:new, :create, :destroy]

  resources :items, only: [:new, :create, :show, :edit, :destroy] do
    resources :likes, only: [:create, :destroy] 


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
