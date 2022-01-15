Rails.application.routes.draw do
  devise_for(
    :admins,
    path: 'admins',
    module: 'admin/admins'
  )
  devise_for(
    :customers,
    path: '/',
    module: 'public/customers'
  )
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # public側のルーティング

  scope module: :public do

  #homes_controller
  root to: 'homes#top'
  get 'homes/about'

  #items_controller
  resources :items, only:[:index, :show]

  #customers_controller
  get "customers/my_page", to: 'customers#show', as: :my_page_customers
  resource :customers, only:[:edit, :update] do
    collection do
      get   :unsubscribe_confirmation
      patch :unsubscribe
    end
  end

  #cart_items_controller
  resources :cart_items, only:[:index, :update, :destroy, :create] do
    collection do
      delete :destroy_all
    end
  end

  #orders_controller
  resources :orders, only:[:new, :index, :show, :create] do
    collection do
      post :confirm
      get  :thanks
    end
 end

 #addresses_controller
 resources :addresses, only:[:index, :edit, :create, :update, :destroy]
 end

 #admin側のルーティング

 namespace :admin do
   root to: 'homes#top' #homes_controller
   resources :items, except:[:destroy] #items_controller
   resources :genres, only:[:index, :create, :edit, :update] #genres_controller
   resources :customers, only:[:index, :show, :edit, :update] #customers_controller
   resources :orders, only:[:show, :update] #orders_controller
   resources :order_details, only:[:update] #order_details_controller
 end

end
