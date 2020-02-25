Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  

  resources :items, only: [:new, :create, :show, :edit, :destroy]
  resources :sendings, only: [:new, :create]
  resources :users, only: [:edit]
  resources :cards, only: [:new, :create, :destroy]
  resources :orders, only: [:index, :new, :create] do  

    collection do
      post 'pay', to: 'orders#pay'
      get 'done', to: 'orders#done'
    end
  end
end