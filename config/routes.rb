Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :accounts, only: [:new, :create]
end
