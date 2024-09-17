Rails.application.routes.draw do
  get '/auth/stripe/connect', to: 'stripe#connect', as: 'stripe_connect'
  get '/auth/stripe/create_account', to: 'stripe#create_account', as: 'stripe_create_account'
  get '/auth/stripe/callback', to: 'stripe#callback', as: 'stripe_callback'
  get "stripe/dashboard/:user_id", to: "stripe#dashboard", as: :stripe_dashboard
  
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

  post 'create_checkout_session', to: 'payments#create_checkout_session'

  resources :buyers
  resources :vendors
  resources :profiles, only: [:show, :edit, :update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  get 'dashboard', to: 'dashboard#index'

 root to: 'home#index'
end