Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do
    resources :teams, only: [:new, :create]
  end
  root 'pages#home'
  get 'our-plans', to: 'pages#plans'
  resources :plans
  resources :boards do
    resources :task_lists, shallow: true do
      resources :tasks, only: [:new, :index, :create]
    end
  end
  resources :tasks, only: [:show, :edit, :update, :destroy]
  get 'complete_task/:id', to: 'tasks#complete_task'
  post 'complete_task/:id', to: 'tasks#complete_task_action'
  resources :task_users, only: [:create, :destroy]
end
