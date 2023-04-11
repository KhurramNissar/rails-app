Rails.application.routes.draw do
  get 'users/index'
  root to: "projects#index"
  resources :projects do
    resources :tasks
  end
  devise_for :users
  resources :managers
end
