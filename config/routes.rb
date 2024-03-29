SampleApp::Application.routes.draw do

  resources :partners


scope "(:locale)", :locale => /en|de/ do

  resources :users do
    member do
      get :following, :followers, :interests, :microposts, :visitors
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts do
    resources :comments
    
  end

  resources :interests, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :invitations, only: [:create, :destroy]
  resources :mindposts, only: [:create, :destroy]
  
  get "users/new"

root to: 'static_pages#home'

match 'auth/:provider/callback', to: 'sessions#create'
match '/auth/failure', to: redirect('/')
match 'signout', to: 'sessions#destroy', as: 'signout'

match 'de/auth/:provider/callback', to: 'sessions#create'

 match '/signup', to: 'users#new'
 match '/signin', to: 'sessions#new'
# match '/signout', to: 'sessions#destroy', via: :delete

match '/help', to: 'static_pages#help'

match '/closeiframe', to: 'static_pages#closeiframe'

match '/about', to: 'static_pages#about'

match '/contact', to: 'static_pages#contact'

match '/search', to: 'static_pages#search'

match '/terms', to: 'static_pages#terms'

match '/news', to: 'static_pages#news'

match '/privacy', to: 'static_pages#privacy'

match '/microposts/:id', to: 'microposts#show'

 match '/comments/:id', to: 'comments#edit'

 match '/write', to: 'static_pages#write'

 match '/result', to: 'static_pages#result'

end #local scope end


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
