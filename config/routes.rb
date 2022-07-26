# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'posts#index'

  devise_for :users
  resources :posts do
    resource :reactions, only: %i[create destroy]
    resources :comments do
      resource :reactions, only: %i[create destroy]
      resources :comments
      resource :reports, only: %i[create destroy]
    end
    resources :suggestions, only: %i[new create show destroy accept] do
      resources :comments, only: %i[create edit update destroy]
    end
    resource :reports
  end
  get '/posts/accept/:id', to: 'posts#accept_post', as: 'moderator_accept'
  get '/profile/pending_posts', to: 'posts#profile', as: 'moderator_profile'
  get '/suggestions/accept', to: 'suggestions#accept', as: 'suggestion_accept'
end
