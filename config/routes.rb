Rails.application.routes.draw do
  get 'courses/new'

  get 'courses/create'

  get 'sessions/new'

  root 'menus#home'  
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"
 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
