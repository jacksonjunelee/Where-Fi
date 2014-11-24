Rails.application.routes.draw do
  get 'users/forgotten_password' => 'users#forgotten_password'
  resources :users, except: [:index] do
  	member do
  		post    ':location_id/' => 'users#add_location', as: :add_favorite_to
  		delete  ':location_id/' => 'users#remove_location', as: :remove_favorite_to
  	end
  end
  resources :comments, only: [:new, :create]

  resources :locations do
    member do
      get 'chart' => 'locations#chart', as: :chart
    end
  end

  get 'sessions/new' => 'sessions#new', as: 'login'
  post 'sessions'    => 'sessions#create'
  delete 'sessions'  => 'sessions#destroy'

  root 'application#home'
end
