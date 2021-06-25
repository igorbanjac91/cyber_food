Rails.application.routes.draw do

  root 'home#index'

  devise_scope :user do 
    get 'sign_up', to: "registrations#new"
    post 'sign_up', to: "registrations#create"
    get 'log_in', to: "sessions#new"
    delete 'log_out', to: "sessions#destroy"
  end

  devise_for :users

end
