Scripting::Application.routes.draw do

  #match '/autocomplete/people' => "autocomplete#people"
  get "videos/showmy"
  
  get "admin/admin/administrate_users"
  get "admin/admin/make_advisor"
  get "admin/admin/unmake_advisor"
  get "admin/admin/destroy_user"
  get "sequences/destroy", :as => 'destroy_sequence'
  
  resources :people
  resources :addresses

  devise_for :admins
  devise_for :users, :path_names => { :sign_up => "register" }
  
  devise_scope :user do
    resources :shows
    resources :videos do
      get :autocomplete_person_name, :on => :collection
      get 'script', :on => :collection
      put 'add_role', :on => :member
    end
    
    resources :roles do
      get :autocomplete_person_name, :on => :collection
    end
    
    resources :treatments
    resources :sequences do
      post 'sort', :on => :collection
    end
    
    resources :szenes do 
      post :sort, :on => :collection
    end
    
    resources :takes do
      resources :pictures
      get :autocomplete_address_address, :on => :collection
      post :sort, :on => :collection
    end
    
    resources :characters do
	get :autocomplete_person_name, :on => :collection
    end
  end
  

  

  # redirect after sign_up
  match 'dashboard' => 'application#personalize', :as => 'user_root'
  match 'administrate' => 'admin/admin#administrate', :as => 'admin_root'
 
  
  match '/about', :to=>'pages#about'
  match '/contact', :to=>'pages#contact'
  match '/help', :to=>'pages#help'


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
  root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
