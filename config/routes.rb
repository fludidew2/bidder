Rails.application.routes.draw do
  devise_for :users
  resources :invoices, only: [:show]
  resources :orders
  resources :bids
  resources :requests do
    member do
      patch :accept_bid
      get :generate_invoice
    end
  end

  resources :buyers
  resources :vendors
  resources :profiles, only: [:show, :edit, :update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  get 'dashboard', to: 'dashboard#index'

 root to: 'home#index'
end