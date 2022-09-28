Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'our-plans', to: 'pages#plans'
  resources :plans
  resources :boards do
    resources :task_lists, shallow: true
  end
  resources :tasks, only: [:new, :create]
end
