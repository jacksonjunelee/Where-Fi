Rails.application.routes.draw do
  resources :users, except: [:index]

  resources :locations, except: [:index]

  get 'sessions/new' => 'sessions#new', as: 'login'
  post 'sessions'    => 'sessions#create'
  delete 'sessions'  => 'sessions#destroy'
end
