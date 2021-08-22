Rails.application.routes.draw do
  devise_for :users

  root 'tasks#index'

  get 'tasks/index'
  get 'compiler/execute'
  post 'compiler/submit_code' , to: 'compiler#submit_code'
  post 'tasks/test_code' , to: 'tasks#test_code'
  resources :tasks, only: [:show, :index]
  resources :categories, only: [:show]

  namespace :admin do
    resources :tasks, except: [:show, :index]
    resources :categories, except: [:show]
  end
end
