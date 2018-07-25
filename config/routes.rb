Rails.application.routes.draw do
  root 'menus#home'  
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"
  resources :users
end
