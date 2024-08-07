Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :admin do
    post '/register', to: 'user#register'
    post '/login', to: 'user#login'
    delete '/logout', to: 'user#logout'
    post 'create_brand', to: 'brand#create_brand'
    get 'brand_list', to: 'brand#brand_list'
    post 'create_product', to: 'product#create_product'
    get 'product_list', to: 'product#product_list'
    delete 'delete_product', to: 'product#delete_product'
    patch 'update_product', to: 'product#update_product'
    patch 'update_state_brand', to: 'state_management#update_state_brand'
    patch 'update_state_product', to: 'state_management#update_state_product'
    post 'create_client', to: 'client#create'
    get 'cancel_card_histories', to: 'insight#cancel_card_histories'
    get 'payments_of_clients', to: 'insight#payments_of_clients'
  end

  post 'login', to: 'session#login'
  delete 'logout', to: 'session#logout'
  post 'create_order', to: 'order#create'
  delete 'cancel_order', to: 'order#destroy'
  post 'create_card', to: 'card#create'
  patch 'cancel_card', to: 'card#cancel_card'
  post 'create_payment', to: 'payment#create'
end
