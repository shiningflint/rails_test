Rails.application.routes.draw do
  root to: 'application#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:show, :edit]
  resources :photos, only: [:create]
  resources :tweets, only: [:create]

  #oauth2 routes
  get '/oauth/callback', to: 'oauth#oauth_callback'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
