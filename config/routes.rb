# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'tasks#index'

  get 'compiler/execute'
  post 'compiler/submit_code', to: 'compiler#submit_code'
  resources :tasks, only: %i[show index test_code]
  resources :categories, only: [:show]

  namespace :admin do
    resources :tasks, shallow: true, except: %i[show index]
    resources :categories, shallow: true, except: [:show]
  end
end
