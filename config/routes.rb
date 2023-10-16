Rails.application.routes.draw do
  root "static_pages#top"
  get 'first_login', to: 'static_pages#first_login'
  patch 'first_login', to: 'static_pages#update'
  put 'first_login', to: 'static_pages#update'
  resources :users, only: [:edit, :update, :show]
  resource :profile, only: [:edit, :update, :show]
  resources :drink_records, only: [:new, :create, :show, :edit, :update, :destroy]

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
