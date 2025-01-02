Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [ :create ]
      resources :products
      resources :carts do
        resources :cart_items, only: [ :create, :destroy ]
        post :checkout, to: "checkout#create"
      end
    end
  end

  post "/api/v1/login", to: "api/v1/sessions#create"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
