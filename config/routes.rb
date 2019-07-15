Rails.application.routes.draw do
  resources :checks
  resources :banks
  resources :box_details
  resources :boxes
  resources :account_sales
  resources :presentations
  resources :setting_currency_companies
  resources :movements
  resources :price_lists
  resources :prices
  resources :receptions
  resources :stocks
  resources :purchase_order_lines_taxes
  resources :payment_terms
  resources :currency_rates
  resources :currencies
  resources :taxes
  resources :accounts
  resources :suppliers
  resources :payments
  resources :payment_types
  resources :addresses
  resources :provinces
  resources :avenidas
  resources :zonas
  resources :departamentos
  resources :user_modulos
  resources :modulos
  resources :rols
  resources :inventory_items
  resources :inventories
  resources :contacts
  resources :clients
  resources :warehouses
  resources :companies
  resources :countries
 resources :sales do
    resources :sale_details
  end
resources :purchase_orders do
  resources :purchase_order_lines
 end


	 get '/brands_suggestion', to: 'brands_suggestion#index'
   get '/validate_suggested_brand', to: 'validate_suggested_brand#index'
  resources :items
  resources :towns
  resources :units
  resources :categories
  resources :brands
  devise_for :users
  resources :users
  get '/items_view_list', to: 'items#items_view_list'
  get '/items_view_kamback', to: 'items#items_view_kamback'
  get 'home/index'
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  get '/items_suggestion', to: 'items_suggestion#index'
  get '/validate_suggested_item', to: 'validate_suggested_item#index'
  get '/validate_suggested_item_purchase', to: 'validate_suggested_item#purchase_item_suggested'
  
  get '/validate_country', to: 'countries#validate'
  get '/stocks_validate_qty', to: 'stocks#validate'

  # obtener cliente en las ventas
   get '/clients_get_client', to: 'clients#cliente_sale'
   get '/prices_get_price_list', to: 'price_lists#price_list_price'

   get '/sales_suggestion', to: 'sales_suggestion#index'
   get '/validate_suggested_sale', to: 'validate_suggested_sale#index'
   get '/prices_select', to: 'prices#myprice'
   get '/myclients', to: 'clients#myclients'

   get '/validate_account_currency', to: 'accounts#currency'
end
