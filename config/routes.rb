Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'pending/index'
  # match "/users", to: "users#index", via: "get"

  get "/get_price/:symbol" => "stocks#get_price", as: :get_price

  resources :roles
  devise_for :users
  resources :stocks do
    resources :transactions
  end

  resources :transactions, only: :index
  resources :users, except: :create
  root to: "stocks#index"

  post "create_user" => "users#create", as: :create_user

  authenticate :user, lambda { |u| u.isadmin == true } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
end
