Rails.application.routes.draw do
  root 'events#index'

  resources :events, only: [:index, :show]
  resources :residents do
    get 'sign_in', on: :member
  end
end
