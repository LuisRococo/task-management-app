Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get :plans, to: 'pages#plans'
end
