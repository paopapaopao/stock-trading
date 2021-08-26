Rails.application.routes.draw do
  get 'pending/index'
  # match "/users", to: "users#index", via: "get"

  resources :roles
  devise_for :users
  resources :stocks do
    resources :transactions
  end

  resources :transactions, only: :index
  resources :users, except: :create
  root to: "stocks#index"

  post "create_user" => "users#create", as: :create_user
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
