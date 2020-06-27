Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"


  resources :merchants do
    resources :items, only: [:index, :new, :create, :show]
  end
  # get "/merchants", to: "merchants#index"
  # get "/merchants/new", to: "merchants#new"
  # get "/merchants/:id", to: "merchants#show"
  # post "/merchants", to: "merchants#create"
  # get "/merchants/:id/edit", to: "merchants#edit"
  # patch "/merchants/:id", to: "merchants#update"
  # delete "/merchants/:id", to: "merchants#destroy"
  resources :items, except: [:new, :create] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]

  # get "/items", to: "items#index"
  # get "/items/:id", to: "items#show"
  # get "/items/:id/edit", to: "items#edit"
  # patch "/items/:id", to: "items#update"
  # delete "/items/:id", to: "items#destroy"

  # get "/merchants/:merchant_id/items", to: "items#index"
  # get "/merchants/:merchant_id/items/new", to: "items#new"
  # post "/merchants/:merchant_id/items", to: "items#create"


  # get "/items/:item_id/reviews/new", to: "reviews#new"
  # post "/items/:item_id/reviews", to: "reviews#create"
  #
  # get "/reviews/:id/edit", to: "reviews#edit"
  # patch "/reviews/:id", to: "reviews#update"
  # delete "/reviews/:id", to: "reviews#destroy"
#:path => "rabbits/categories"
  # resources :cart do
  #   member do
  #     patch 'add_quantity'
  #     patch 'delete_quantity'
  #   end
  # end


  # resources :cart, only: [:show] do
  #   member do
  #     delete 'empty'
  #   end
  # end

  # resources :cart do
  #   member do
  #     post 'add_item'
  #     delete 'remove_item'
  #   end
  # end

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id/add_quantity", to: "cart#add_quantity"
  patch "/cart/:item_id/decrease-quantity", to: "cart#decrease_quantity"


  resources :orders, only: [:new, :create, :show, :destroy] do
    member do
      patch 'ship'
    end
  end

  # get "/orders/new", to: "orders#new"
  # post "/orders", to: "orders#create"
  # get "/orders/:id", to: "orders#show"
  #patch "/orders/:id/ship", to: "orders#ship"
  # delete "/orders/:id", to: "orders#destroy"

  resources :users, only: [:new, :create], path_names: {new: 'register', create: 'new'}
  #get "/register", to: "users#new"


  #post "/users/new", to: "users#create"


  resources :profile, only: [:index, :edit, :update]
  #get "/profile", to: "profile#index"
  get "/profile/:id/admin", to: "profile#index"
  #get "/profile/:id/edit", to: "profile#edit"
  #patch "/profile/:id", to: "profile#update"

  resources :password, only: [:edit, :update]

  # get "/password/:user_id/edit", to: "password#edit"
  # patch "/password/:user_id", to: "password#update"

  resources :sessions, path: 'login', only: [:new, :create], path_names: { new: "" }

  # get "/login", to: "sessions#new"
  # post "/login", to: "sessions#create"


  resources :profile_orders, only: [:index, :show], :path => 'profile/orders'

  # get "profile/orders", to: "profile_orders#index"
  # get "profile/orders/:id", to: "profile_orders#show"


  namespace :merchant do
    resources :items do
      resources :orders, params: :order_id
    end
    resources :orders, only: [:show], param: :order_id
    # get "/items/new", to: "items#new"
    # post "/items", to: "items#create"
    # get "/items/:item_id/edit", to: "items#edit"
    #
    # patch "/items/:item_id", to: "items#update"
    # delete "/items/:item_id", to: "items#destroy"
    root "dashboard#index"
    # get "/items", to: "items#index"
    get "/dashboard", to: "dashboard#index"

  #  get "/orders/:order_id", to: "orders#show"
  #  patch "/items/:item_id/orders/:order_id", to: 'orders#update'

  end



  namespace :admin do
    resources :merchants do
      resources :items
    end
    root "dashboard#show"
    resources :profile, only: [:index]
    #get "/profile", to: "profile#index"
    # get "/merchants", to: "merchant#index"
    # patch "/merchants/:id/update", to: "merchant#update"
    # get "/merchants/:merchant_id/items", to: "items#index"
    # delete "/merchants/:merchant_id/items/:item_id", to: "items#destroy"
    # post "/merchants/:merchant_id/items", to: 'items#create'
    # get "/merchants/:merchant_id/items/new", to: "items#new"
    # get "/merchants/:merchant_id/items/:item_id/edit", to: 'items#edit'
    # patch "/merchants/:merchant_id/items/:item_id", to: "items#update"

    # get "/merchants/:id", to: "merchant#show"
    get "/dashboard", to: "dashboard#show"

    resources :users, only: [:index, :show]
    # get "/users", to: "users#index"
    # get "/users/:user_id", to: "users#show"

  end

  resources :logout, only: [:index]
end
