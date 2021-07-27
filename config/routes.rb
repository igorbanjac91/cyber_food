Rails.application.routes.draw do

  root 'pages#index'

  devise_scope :user do 
    get 'sign_up', to: "devise/registrations#new"
    post 'sign_up', to: "devise/registrations#create"
    get 'log_in', to: "devise/sessions#new"
    delete 'log_out', to: "devise/sessions#destroy"
  end
  
  devise_for :users

  namespace :api, defaults: { format: :json } do 
    namespace :v1 do 
      resources :food_items, only: [:index, :show]
      resources :categories, only: [:index, :show, :create]
      resources :order_items, only: [:create]
      resources :orders, only: [:show]
    end
  end


  match '/orders/:id', to: 'pages#index', via: :all
  match '/orders', to: 'pages#index', via: :all
  match '/', to: 'pages#index', via: :all
end
