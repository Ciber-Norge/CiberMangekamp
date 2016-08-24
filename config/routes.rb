Rails.application.routes.draw do
  root 'seasons#index'

  resources :seasons do
    resources :events
  end

  resources :events do
    resources :participant, :only => [:create, :destroy]
    resource :participants, :only => [] do
      get :mass_add
      post :mass_create
    end
    resources :result
    resource :results, :only => []  do
      get :mass_new, :mass_edit
      post :mass_create, :mass_update
    end
  end

  resources :users do
  end

  get '/login'  => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
