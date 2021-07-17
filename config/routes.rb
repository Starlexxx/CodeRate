Rails.application.routes.draw do
  get 'tasks/index'
  resources :tasks
  resources :categories
  root 'tasks#index'
end
