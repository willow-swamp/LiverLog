Rails.application.routes.draw do
  root "static_pages#top"
  get 'first_login', to: 'static_pages#first_login'
  patch 'first_login', to: 'static_pages#update'
  put 'first_login', to: 'static_pages#update'
  # resources :users, only: [:edit, :update, :show]
  resource :profile, only: [:edit, :update, :show]
  resources :drink_records, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :groups, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :posts, only: [:create, :show] do
      resources :post_comments, only: [:create, :show, :destroy], shallow: true
    end
  end

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  namespace :invitees do
    get 'invitation/new/:invite_token', to: 'invitation#new'
    get 'invitation/first_login', to: 'invitation#first_login'
    post 'oauth/callback', to: 'oauths#callback'
    get 'oauth/callback', to: 'oauths#callback'
    get 'oauth/:provider/:invite_token', to: 'oauths#oauth', as: :auth_at_provider
  end
end
