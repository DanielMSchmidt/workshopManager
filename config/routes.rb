Rails.application.routes.draw do
  post 'subscription/add'
  put 'subscription/remove'

  resources :events, except: [:show]

  devise_for :users
  root 'static#index'
end
