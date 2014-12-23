Rails.application.routes.draw do
  resources :events, except: [:show]

  devise_for :users
  root 'static#index'
end
