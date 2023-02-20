# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'tasks#index'

  get 'compiler/execute'
  get 'compiler/submit_code'
  post 'compiler/submit_code', to: 'compiler#submit_code'

  post 'tasks/test_code', to: 'tasks#test_code'

  resources :tasks, only: %i[show index test_code]
  resources :categories, only: [:show]

  namespace :admin do
    resources :tasks, except: %i[show index]
    resources :categories, except: [:show]
  end
end
