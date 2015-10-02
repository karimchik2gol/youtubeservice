Youtubeservice::Application.routes.draw do
  resources :offers


  resources :categories


  resources :admins


  get "index/index"

  get "/index/logout"
  
  get "index/start"

  get "index/registration"

  get "search", to: "index#search"

  get "category/:id", to: "index#category"

  get "/index/searchingCheckbox"
  
  get "/profile/:id", to: "index#profile"

  get "/offer", to: "index#offers"

  get "/createoffer", to: "index#createoffer"
  
  get "admin", to: "index#admin"

  post "/index/createofferpost"

  get '/youtube/auth', to: "index#getyoutubeauth"

  get '/index/wait_new_user', to: "index#wait_new_user"

  get "/editoffer/:id", to: "index#editoffer"

  get "/destroyoffer/:id", to: "index#destroyoffer"

  get "/offer/details/:id", to: "index#offerdetails"

  put "/index/:id/updateoffer", to: "index#updateoffer"

  get "/collabration", to: "index#collabration"

  get "/offerapplycreate/:id", to: "index#offerapplycreate"

  get "/offers/applicants/:id", to: "index#applicants"

  post "/index/createtopic/:id", to: "index#createtopic"
  
  get "/directmessages", to: "index#directmessages"

  get "/topic/:id", to: "index#topic"

  post "/index/createmessage/:id", to: "index#createmessage"

  get "/account", to: "index#account"

  put "/index/:id/update_account", to: "index#update_account"
  
  post "index/checkAdmin"

  post "index/create"

  resources :textdescs


  resources :users

  root :to=>"index#index"


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
