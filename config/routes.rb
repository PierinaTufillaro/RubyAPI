Rails.application.routes.draw do
  resources :phones
  resources :clients

  #Users
  post '/users', to: 'session#createUser'

  #Session 
  post '/session', to: 'session#create'
  delete '/session', to: 'session#delete'
  
  #Products
  get '/products/all', to: 'products#all'
  get '/products/scarce', to: 'products#scarce'
  get '/products', to: 'products#in_stock'
  get '/products/:codigo', to:'products#searchOne'
  get '/products/:codigo/items', to:'products#searchItems'
  post '/products/:codigo/items', to: 'products#sumItems'

  #Reservations
  get '/reservations', to: 'reservations#all'
  get '/reservations/:id', to: 'reservations#searchOne'
  post '/reservations', to: 'reservations#createOne'
  put '/reservations/:id/sell', to: 'reservations#sellOne'
  delete '/reservations/:id', to: 'reservations#delete'

  #Sells
  get '/sells', to: 'sells#all'
  get '/sells/:id', to: 'sells#searchOne'
  #devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
