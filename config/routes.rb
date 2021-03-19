Rails.application.routes.draw do
  root "sessions#home"

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  #login route
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  #logout route
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:show, :edit]
  
  shallow do
    resources :schools, :shallow => true do
      resources :posts do
        resources :comments
      end
    end
  end

  # resources :subjects do
  #   resources :posts do
  #     resources :comments
  #   end
  # end
  

end
