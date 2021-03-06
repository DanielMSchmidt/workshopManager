Rails.application.routes.draw do

  get 'message/index'

  post 'subscription/add'
  post 'subscription/notify'
  get 'subscription/:unsubscribe_token/remove' => 'subscription#remove', as: "subscription_remove"

  namespace :public do
    resources :events, only: [:show]
    resources :user, only: [:show]
  end

  resources :events do
    get 'subscribe', on: :member
    get 'unsubscribe', on: :member
  end

  resources :users, only: [] do
    get "subscribe" => "subscription#new_for_user", on: :member
  end

  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root 'static#index'
end
