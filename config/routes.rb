Rails.application.routes.draw do
  get 'students/new'

  get 'students/create'

  get 'courses/new'

  get 'courses/create'

  get 'sessions/new'

  root 'menus#home'  
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"

  get '/user/:id/start' => 'users#start', as: :start
  get '/user/:id/end' => 'users#end', as: :end
 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
