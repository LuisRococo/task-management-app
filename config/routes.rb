Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'our-plans', to: 'pages#plans'
  resources :plans, only: [:index, :edit, :update, :new, :create, :destroy]
  resources :boards, only: [:index, :show, :destroy, :new, :create, :edit, :update]
  resources :task_lists, only: [:new, :create]
end
