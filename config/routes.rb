Rails.application.routes.draw do
  devise_for :users
  get '*path' => 'application#index'
  root 'application#index'
end
