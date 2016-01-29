
DefaultInit::Application.routes.draw do
  
  resources :campaigns do
    member do
      get 'choose'
      post 'update_group'
    end
  end


  mount Ckeditor::Engine => '/ckeditor'
  # resources :comments
  # get '/new_reply' => 'comments#new_reply'

  # resources :blogs

  # OPCIIONALES
  resources :pre_users, only: [:create]
  get 'maps/index'

  #G+ login
  get 'auth/:provider/callback', to: 'sessions#create_with_oauth'  
  get 'auth/failure', to:  "home#index"

  get "admins/dashboard", to:  "admins#dashboard", as: 'admin_home'
  get "admins/podio", to:  "admins#podio_info", as: 'podio_info'
  get "admins/podio_item/:item_id", to:  "admins#podio_item", as: 'podio_item'


  get "sessions/new"
  get "home/index"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "activate/:token" => "users#activate", :as => "activate"

  #Recover pass
  get "recover_pass" => "sessions#recover_pass", :as => "recover_pass"
  post "send_pass_recovery" => "sessions#send_pass_recovery", :as => "send_pass_recovery"
  get "change_password/:token" => "sessions#change_password", :as => "change_password"
  post "do_change_password" => "sessions#do_change_password", :as => "do_change_password"

  #To desuscribe from contact emails
  get "unsubscribe/:token" => "sessions#unsubscribe", :as => "unsubscribe"
  get "unsubscribe/:token/:from" => "sessions#unsubscribe", :as => "unsubscribe_from"
  get "contact" => "home#contact", :as => "contact"
  post "send_contact" => "home#send_contact", :as => "send_contact"

  resources :sessions
  resources :users

  get "home" => "home#index", :as => "home"
  root :to => "home#index"

  #API
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      resources :users
      get "/log_in" => "users#show"
      post "/log_in" => "users#show"
      post "/sign_up" => "users#create"
    end
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
