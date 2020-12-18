Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :tickets, only: [:new, :create, :show, :index, :destroy] do
    resources :items, only: [:index]
  end
  resources :items, only: [:show, :edit, :update, :destroy]
  resources :products, only: [:show, :update]
  resources :favorites, only: [:index, :create, :destroy]
  get 'settings', to: 'pages#settings'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
