Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'our-plans', to: 'pages#plans'
  resources :plans, only: [:index, :edit, :update]
  resources :boards, only: [:index, :show, :destroy, :new, :create]
  resources :task_lists, only: [:new, :index]
end
