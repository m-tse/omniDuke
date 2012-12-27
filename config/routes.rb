OmniDuke::Application.routes.draw do

  devise_for :users
  
  root :to => 'static_pages#home'
  match '/home', to: 'static_pages#home'
  match '/courses/results', to: 'courses#results'
  match '/instructors/results', to: 'instructors#results'
  match '/subjects/results', to: 'subjects#results'
  match '/omni_results', to: 'searches#results'
  match '/subjects/instructors', to: 'subjects#show_instructors'
  match '/subjects/courses', to: 'subjects#show_courses'
  match '/schedulator/saved', to: 'schedulator#show_saved'
  match '/schedulator/current', to: 'schedulator#show_current'
  resources :courses, only: [:index, :show]
  resources :instructors, only: [:index, :show]
  resources :reviews, only: [:new, :show, :create]
  resources :subjects, only: [:show, :index]
  resources :schedulator
  resources :bookbag_relationship, only: [:create, :destroy]
  resources :schedule_relationship, only: [:create, :destroy]
  resources :schedulator_saved_relationships, only: [:create, :destroy]
  
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
