Rails.application.routes.draw do
  get '/sign_up' => 'users#new', as: :sign_up

  get '/user' => 'users#index', as: :user

  mount Resque::Server, :at => "/resque"

  # get 'users/new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#new'

  get "/auth/google_oauth2/callback" => 'sessions#oauth', as: :google

  get '/auth/failure' => 'sessions#failure', as: :failure

  get '/sign_in' => 'sessions#new', as: :session
  post '/sign_in' => 'sessions#create'

  delete '/log_out' => 'sessions#destroy', as: :logout

  get '/user/:user_id/list' => 'products#list', as: :list

  post '/user/:user_id/list' => 'products#create'

  get '/user/:user_id/food' => 'products#index', as: :user_food

  patch '/user/:user_id/food' => 'products#update'

  patch '/user_products/date' => 'products#update_date', as: :update_date

  post '/product_check' => 'products#product_check', as: :product_check
  get '/product_check' => 'products#product_check'
  get '/product_form/:product' => 'products#product_form', as: :product_form

  post '/product_select' => 'products#product_select', as: :product_select

  get 'products/autocomplete_product_name' => 'products#autocomplete_product_name', as: :autocomplete

  patch '/user/:user_id/user_product/change_location' => 'products#change_location', as: :change_location


  resources :users


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
