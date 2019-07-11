Rails.application.routes.draw do
  get 'students/new'

  get 'students/create'

  get 'courses/new'

  get 'courses/create'

  get 'sessions/new'

  get '/users/dashboard'
  post '/create_semester', to: 'semesters#create'
  patch '/users/edit'
  
  root 'menus#home'  
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"

  get '/create_course', to: "courses#new"
  post '/create_course', to: "courses#create"

  get '/user/:id/start' => 'users#start', as: :start
  get '/user/:id/end' => 'users#end', as: :end
  post '/user/set_limit' => 'users#set_limit'
 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/get_help', to: 'students#new'
  post '/get_help', to: 'students#create'

  get '/student/:student_id/help' => 'students#help', as: :help
  get 'student/:student_id/end_session' => 'students#end_session', as: :end_session
  resources :users

  post '/lti/launch'
  get '/lti/config'
end
