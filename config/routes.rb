Rails.application.routes.draw do
  get '*path' => 'application#index'
  root 'application#index'
end
