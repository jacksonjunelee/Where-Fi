Rails.application.routes.draw do
  resources :users, except: [:index]

  resources :locations

  get 'sessions/new' => 'sessions#new', as: 'login'
  post 'sessions'    => 'sessions#create'
  delete 'sessions'  => 'sessions#destroy'

  root 'application#home'
end
