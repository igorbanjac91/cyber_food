Rails.application.routes.draw do

  root 'pages#index'

  devise_scope :user do 
    get '/sign_up', to: "users/registrations#new"
    post '/sign_up', to: "users/registrations#create"
    get '/log_in', to: "users/sessions#new"
    delete '/log_out', to: "users/sessions#destroy"
  end
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  namespace :api, defaults: { format: :json } do 
    namespace :v1 do 
      resources :food_items
      resources :categories
      resources :order_items, only: [:create, :update, :destroy]
      resources :orders, only: [:index, :show, :update]
    end
  end

  resources :checkout, only: [:create], defaults: { format: :json }
  resources :webhooks, only: [:create]

  get "/success", to: 'checkout#success'
  get "/cancel", to: 'checkout#cancel'

  match '/users/orders', to: 'pages#index', via: :all, as: :user_orders
  match '/dashboard/food-items', to: 'pages#index', via: :all, as: :food_items
  match '/dashboard/categories', to: 'pages#index', via: :all, as: :categories
  match '/dashboard/orders', to: 'pages#index', via: :all, as: :orders
  match '/orders/:id', to: 'pages#index', via: :all
  match '/orders', to: 'pages#index', via: :all
  match '/', to: 'pages#index', via: :all
end
