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
      resources :food_items, only: [:index, :show, :create]
      resources :categories, only: [:index, :show, :create]
      resources :order_items, only: [:create, :update, :destroy]
      resources :orders, only: [:index, :show]
    end
  end

  resources :checkout, only: [:create], defaults: { format: :json }
  resources :webhooks, only: [:create]

  get "/success", to: 'checkout#success'
  get "/cancel", to: 'checkout#cancel'

  match '/dashboard', to: 'pages#index', via: :all
  match '/orders/:id', to: 'pages#index', via: :all
  match '/orders', to: 'pages#index', via: :all
  match '/', to: 'pages#index', via: :all
end
