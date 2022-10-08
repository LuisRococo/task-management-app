Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, only: [:show, :edit, :update] do
    resources :teams, only: [:new, :create, :index]
    resources :boards, shallow: true
  end
  delete 'end_trial/:id', to: 'users#end_trial'
  post 'set_plan', to: 'users#set_plan'
  root 'pages#home'
  get 'our-plans', to: 'pages#plans'
  
  resources :plans
  resources :boards, except: [:index, :new, :create] do
    resources :task_lists, shallow: true do
      resources :tasks, only: [:new, :index, :create]
    end
  end
  post 'toggle_board_visibility/:id', to: 'boards#toggle_visibility'
  
  resources :tasks, only: [:show, :edit, :update, :destroy]
  get 'complete_task/:id', to: 'tasks#complete_task'
  post 'complete_task/:id', to: 'tasks#complete_task_action'
  
  resources :task_users, only: [:create, :destroy]

  get 'admin', to: 'admins#admin_menu'

  resources :payments, only: [:create]
  
end
