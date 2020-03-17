Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  get 'users/pools'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'pages#home'


  resources :conversations do
    resources :messages
  end

  resources :bookings, only: [:index, :destroy, :destroybyuser, :edit] # list all user bookings



  resources :pools do
    resources :bookings, only: [:new, :create] # create a booking for a particular pool
    resources :reviews, only: [:new, :create]
  end

  # get "my_puppies", to ""

  resources :users do

    resources :pools, only: [:index, :new, :create]

    # post ':id/bookings', to:'bookings#create', as: 'userbookings'

  end

  get 'my_pools', to: 'pools#mypools' , as: 'usermypools'

  # post '/pools' => 'pools#create'
end
