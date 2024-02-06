Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'static_pages#top'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'first_login', to: 'static_pages#first_login'
  patch 'first_login', to: 'static_pages#update'
  put 'first_login', to: 'static_pages#update'
  resource :profile, only: %i[edit update show]
  resources :drink_records, only: %i[new create show edit update destroy]
  resources :groups, only: %i[new create show edit update destroy] do
    resources :posts, only: %i[create show] do
      resources :post_comments, only: %i[create show destroy], shallow: true
      member do
        resources :likes, only: %i[create destroy]
      end
    end
  end
  resources :community_posts

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  namespace :invitees do
    get 'invitation/new/:invite_token', to: 'invitation#new'
    get 'invitation/first_login', to: 'invitation#first_login'
    patch 'invitation/first_login', to: 'invitation#update'
    get 'oauth/:provider/:invite_token', to: 'oauths#oauth', as: :auth_at_provider
  end
end
