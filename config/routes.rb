Caachen::Application.routes.draw do

  resources :services do
    collection do
      post :rebuild # required for Sortable GUI server side actions
    end
  end

  resources :gatherings

  devise_for :users
  resources :groups
  resources :friends

  namespace :admin do
    resources :users
    resources :permissions
  end

  root :to => 'pages#welcome'
  resources :contacts do
    collection do
      match 'update_month' => 'contacts#update_month', via: [:get], as: :update_month
      post :import
      get :newimport
    end
  end

  resources :calendars do
    collection do
      match 'edit/:datum' => 'calendars#services_edit', via: [:get], as: 'services_edit'
      match 'services_delete/:datum' => 'calendars#services_delete', via: [:delete], as: 'services_delete'
      match 'add_name' => 'calendars#add_name', via: [:post], as: 'add_name'
      match 'update_name' => 'calendars#update_name', via: [:post], as: 'update_name'
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
