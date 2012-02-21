# -*- encoding : utf-8 -*-
Store::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" } do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  resources :authors do
    resources :products
  end

  resources :categories do
    resources :products do
      resource :comments, :only => [:create]
    end
  end


  resources :orders, :line_items, :carts

  namespace :admin do
    resources :orders, :line_items, :carts, :comments, :users, :reports, :expenses
    resources :authors do
      resources :products
    end
    resources :categories do
      resources :products
    end
    resources :post_categories do
      resources :posts
    end

  end
  match 'admin' => 'admin/dashboard#index'
  match 'admin/get_picture' => 'admin/dashboard#get_picture', :as=>"get_picture"

  match 'q' => 'products#search', :as => :search_products
  match '/home/:slug' => 'home#show'

  match '/:post_category_slug/:post_slug/comment' => 'comments#create', :as => :add_comment
  match '/:post_category_slug/:post_slug' => 'posts#show', :as => :short_post
  match '/:post_category_slug' => 'posts#index', :as => :short_cat_posts

  match '/:post_category_slug' => 'posts#index', :as => :short_cat_posts


  root :to => 'home#index'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

end
