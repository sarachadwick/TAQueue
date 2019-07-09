Rails.application.routes.draw do
  get 'students/new'

  get 'students/create'

  get 'courses/new'

  get 'courses/create'

  get 'sessions/new'

  root 'menus#home'  
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"

  get '/create_course', to: "courses#new"
  post '/create_course', to: "courses#create"

  get '/user/:id/start' => 'users#start', as: :start
  get '/user/:id/end' => 'users#end', as: :end
 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/get_help', to: 'students#new'
  post '/get_help', to: 'students#create'

  get '/student/:student_id/help' => 'students#help', as: :help
  get 'student/:student_id/end_session' => 'students#end_session', as: :end_session
  resources :users

  post '/lti/launch'
end
