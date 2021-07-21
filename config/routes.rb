Rails.application.routes.draw do

  root 'pages#index'

  devise_scope :user do 
    get 'sign_up', to: "registrations#new"
    post 'sign_up', to: "registrations#create"
    get 'log_in', to: "sessions#new"
    delete 'log_out', to: "sessions#destroy"
  end

  devise_for :users

  namespace :api, defaults: { format: :json } do 
    namespace :v1 do 
      resources :food_items, only: [:index, :show]
      resources :categories, only: [:index, :show]
      resources :orders, only: [:create]
    end
  end

  match '*path', to: 'pages#index', via: :all
end
