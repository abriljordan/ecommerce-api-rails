Rails.application.routes.draw do
  # UI Routes
  root "pages#home"  # Root for the home page
  get "products", to: "pages#products"  # Products page
  get "cart", to: "pages#cart"  # Cart page

  # API Routes
  namespace :api do
    namespace :v1 do
      # User registration and login
      post "register", to: "users#create"  # Register endpoint
      post "login", to: "sessions#create"  # Login endpoint

      # Products and carts
      resources :products  # Product CRUD operations
      resources :carts do
        resources :cart_items, only: [ :create, :destroy ]  # Cart items
        member do
          post :checkout, to: "checkout#create"  # Checkout endpoint
        end
      end
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
