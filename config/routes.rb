Feats::Application.routes.draw do
  root to: 'feats#search'
  
  resources :users do
    options = { only: [ :edit, :update, :show ]}
    get 'search', on: :collection
  end
  resources :feats do
    get 'search', on: :collection
  end    
  resources :locations do     
    options = { only: [ :new, :create, :show ]}
    get 'locate', on: :collection
    get 'choose_from_existing', on: :collection
    get 'select', on: :member
  end 
  resources :attempts
  resources :validations     
  
  match '/signin', to: 'sessions#new'
  match '/auth/facebook/callback', to: 'sessions#create'
  match '/auth/failure', to: redirect('/')
  match '/signout', to: 'sessions#destroy', as: 'signout'
  match '/how_it_works', to: 'static_pages#how_it_works'
  match '/terms', to: 'static_pages#terms_of_use'
  match '/privacy', to: 'static_pages#privacy_policy'
 
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
