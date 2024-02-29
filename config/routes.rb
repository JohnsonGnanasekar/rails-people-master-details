Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  # People resource
  resources :people, defaults: { format: :html } do
    # Details nested resource
    resources :details, defaults: { format: :html }
  end

  # Route for JSON format for both people and details resources
  namespace :api, defaults: { format: :json } do
    resources :people, only: [:index, :show, :create, :update, :destroy] do
      resources :details, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
