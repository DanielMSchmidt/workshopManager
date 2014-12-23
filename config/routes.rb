Rails.application.routes.draw do
  post 'subscription/add'
  put 'subscription/remove'

  resources :events, except: [:show] do
    get 'subscribe', on: :member
  end

  devise_for :users
  root 'static#index'
end
