Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  
  resources :sendings, only: [:new, :create]
  resources :users, only: [:edit]
  resources :cards, only: [:new, :create, :destroy]

  resources :items, only: [:new, :create, :show, :edit, :destroy] do
    resources :likes, only: [:create, :destroy] 

    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end

  end

  resources :orders, only: [:index, :new, :create] do  

    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      post 'pay', to: 'orders#pay'
      get 'done', to: 'orders#done'
    end

  end
end
