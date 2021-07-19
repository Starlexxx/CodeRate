Rails.application.routes.draw do
  devise_for :users
  get 'tasks/index'
  resources :tasks
  resources :categories
  root 'tasks#index'
end
