Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do
    get "/dashboard", controller: :merchants, action: :show, as: "dashboard"
    resources :items, controller: :merchant_items
    resources :invoices, controller: :merchant_invoices
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :merchants
    resources :invoices
  end

  resources :invoices, :invoice_items, only: :update
  resources :users
  resources :login, only: [:new, :create], controller: :sessions

  root 'welcome#index'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
end
