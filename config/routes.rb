Rails.application.routes.draw do
  root 'seasons#index'

  resources :seasons do
    resources :events
  end

  resources :events
  
  get 'events/:id/mass_add', to: 'events#mass_add', as: :mass_add_event
  post 'events/:id/mass_create', to: 'events#mass_create', as: :mass_create_event
  delete 'events/:id/participant/:participant_id', to: 'events#delete_participant', as: :delete_participant_from_event

  get 'events/:id/mass_edit_results', to: 'events#mass_edit_results', as: :mass_edit_results_event
  post 'events/:id/mass_update_results', to: 'events#mass_update_results', as: :mass_update_results_event
  get 'events/:id/edit_result/:participant_id', to: 'events#edit_result', as: :edit_result_event
  patch 'events/:id/update_result/:participant_id', to: 'events#update_result', as: :update_result_event

  resources :users

  get '/login'  => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy' 
end
