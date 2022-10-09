# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: %i[show edit update] do
    resources :teams, only: %i[new create index]
    resources :boards, shallow: true
  end
  delete 'end_trial/:id', to: 'users#end_trial'
  post 'set_plan', to: 'users#set_plan'
  post 'toggle-user-block/:id', to: 'users#toggle_user_block'
  root 'pages#home'
  get 'our-plans', to: 'pages#plans'
  get 'payment-block', to: 'pages#payment_block'
  get 'trial-block', to: 'pages#trial_block'
  get 'user-block', to: 'pages#user_block'

  resources :plans
  resources :boards, except: %i[index new create] do
    resources :task_lists, shallow: true do
      resources :tasks, only: %i[new index create]
    end
  end
  post 'toggle_board_visibility/:id', to: 'boards#toggle_visibility'

  resources :tasks, only: %i[show edit update destroy]
  get 'complete_task/:id', to: 'tasks#complete_task'
  post 'complete_task/:id', to: 'tasks#complete_task_action'

  resources :task_users, only: %i[create destroy]

  get 'admin', to: 'admins#admin_menu'

  resources :payments, only: %i[create new]
end
