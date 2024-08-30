Rails.application.routes.draw do
  devise_for :users
  resources :invoices
  resources :orders
  resources :bids
  resources :requests
  resources :buyers
  resources :vendors
  resources :profiles, only: [:show, :edit, :update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  get 'dashboard', to: 'dashboard#index'

 root to: 'home#index'
end
