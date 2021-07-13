Rails.application.routes.draw do
  resources :tasksкфшдыs
  get 'tasks/index'
  resources :tasks
  root 'tasks#index'
end
