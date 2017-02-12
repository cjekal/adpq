Rails.application.routes.draw do
  root 'events#index'

  resources :events, only: [:index, :show] do
    member do
      get 'ws_notify'
      get 'wp_notify'
    end
  end

  resources :residents do
    get 'sign_in', on: :member
  end
end
