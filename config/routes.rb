Rails.application.routes.draw do
  root 'events#index'

  resources :events, only: [:index, :show]
  resources :residents
end
