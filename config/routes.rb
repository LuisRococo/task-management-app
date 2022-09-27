Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'our-plans', to: 'pages#plans'
  resources :plans
  resources :boards
  resources :task_lists
end
