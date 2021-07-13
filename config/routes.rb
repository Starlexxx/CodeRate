Rails.application.routes.draw do
  get 'tasks/index'
  resources :tasks
  root 'tasks#index'
end
