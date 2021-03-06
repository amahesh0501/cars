Cars::Application.routes.draw do

  devise_for :users

  root :to => 'pages#index'



  resources :pages

  resources :dealerships do
    resources :memberships
    resources :deals
    resources :cars, path:"vehicles"
    resources :expenses
    resources :repairs, path:"vehicle-expenses"
    resources :paychecks
    resources :vendors
    resources :employees
    resources :revenues
    resources :forms
    resources :temps
    resources :commissions
    resources :auctions
    resources :floorers
    resources :cards do
      resources :payments
    end
    resources :partners
    resources :lenders
    resources :menus
    resources :gaps
    resources :warranties
    resources :customers do
      resources :conversations
    end
  end


  match 'users/:id' => 'users#show', via: :get, as: 'user'
  match 'get_dates', :to => 'expenses#get_dates', via: :post
  match 'show_dates', :to => 'expenses#get_dates', via: :post
  match 'approve_member', :to => 'dealerships#approve_member', via: :get
  match 'revoke_member', :to => 'dealerships#revoke_member', via: :get
  match 'admin', :to => 'pages#admin', via: :get
  match 'inactive', :to => 'pages#inactive', via: :get
  match 'mark_inactive', :to => 'dealerships#mark_inactive', via: :get
  match 'mark_active', :to => 'dealerships#mark_active', via: :get
  match 'blocked', :to => 'pages#blocked', via: :get
  match 'test', :to => 'pages#test', via: :get
  match 'dealerships/:id/conversations', :to => 'dealerships#conversations', via: :get
  match 'dealerships/:id/no_access', :to => 'dealerships#no_access', via: :get, as: 'no_access'
  match 'new_with_vin', :to => 'cars#new_with_vin', via: :post
  match 'quick_calculate', :to => 'deals#quick_calculate', via: :post
  match 'dealerships/:id/search', :to => 'dealerships#search', via: :get, as: 'search'
  match 'dealerships/:id/third_parties', :to => 'dealerships#third_parties', via: :get, as: 'parties'
  match 'dealerships/:id/quick_calculate_results', :to => 'deals#show_quick_calculations', via: :get, as: 'quick_calculate_results'
  match 'dealerships/:id/temps/:id/convert', :to => 'temps#convert', via: :get, as: 'temp_convert'








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
