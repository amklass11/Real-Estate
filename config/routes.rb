# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts
  resources :posts
  resources :properties

  get '/blog' => 'posts#latest', as: :blog

  # admin routes
  get '/accounts' => 'admin#accounts', as: :accounts

  get '/dashboard' => 'dashboard#index', as: :dashboard
  get '/profile/:id' => 'dashboard#profile', as: :profile
  post 'agent/message' => 'properties#email_agent', as: :email_agent

  root to: 'public#main'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
