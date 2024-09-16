Rails.application.routes.draw do
  devise_for :users
  resources :invoices, only: [:show]
  resources :orders
  resources :bids
  resources :requests do
    member do
      patch :accept_bid
    end
  end
  post 'generate_invoice', to: 'invoices#generate', as: 'generate_invoice'

  post 'generate_payment', to: 'payments#generate', as: 'generate_payment'

  resources :buyers
  resources :vendors
  resources :profiles, only: [:show, :edit, :update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  get 'dashboard', to: 'dashboard#index'

 root to: 'home#index'
end