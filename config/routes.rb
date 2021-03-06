Rails.application.routes.draw do

  namespace :admin do
    resources :users, except: [:new, :edit]
  end
  with_options except: [:new, :edit] do
    resources :venues do
      resources :phones do
        match '/ping' => 'phones#ping', via: [:get, :post]
        match '/files' => 'phones#files', via: [:get]
        match '/md5_files' => 'phones#md5_files', via: [:get]
        match '/log' => 'phones#log', via: :post
        match '/call_the_phone' => 'phones#call_the_phone', via: [:get]
      end
    end
    resources :stories do
      get 'story_data', on: :collection
    end
  end

  resources :phones, only: :index

  resources :buttons, only: [:create, :update] do
    post 'update_fixed', on: :collection
    get 'index_fixed', on: :collection
    get 'index_star', on: :collection
    get 'index_hash', on: :collection
    get 'index_zero', on: :collection
    get 'index_postroll', on: :collection
  end

  post '/login', to: 'admin/users#login'
  get '/logout', to: 'admin/users#logout'
  get '/resetpassword', to: 'admin/users#resetpassword'
  get 'amazon/sign_key'

  get '/' => redirect('https://github.com/fishermanswharff/callmeishmael-api')

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
