Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :plans, only: [:index]
end
