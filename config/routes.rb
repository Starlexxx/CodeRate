Rails.application.routes.draw do
  devise_for :users

  root 'tasks#index'

  get 'tasks/index'
  get 'compiler/execute'
  post 'compiler/submitcode' , to: 'compiler#submitcode'
  resources :tasks, only: [:show, :index]
  resources :categories, only: [:show]

  namespace :admin do
    resources :tasks, except: [:show, :index]
    resources :categories, except: [:show]
  end
end
