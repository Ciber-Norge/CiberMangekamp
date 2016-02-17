Rails.application.routes.draw do
  root 'seasons#index'

  resources :seasons do
    resources :events
  end

  resources :events do
    resources :participants
    resources :result
    resource :results do
      get :mass_new, :mass_edit
      post :mass_create, :mass_update
    end
  end

  resources :users do
  end
end
