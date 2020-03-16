Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  get 'users/puppies'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'pages#home'


  resources :conversations do
    resources :messages
  end

  resources :bookings, only: [:index, :destroy, :destroybyuser, :edit] # list all user bookings



  resources :puppies do
    resources :bookings, only: [:new, :create] # create a booking for a particular puppy
    resources :reviews, only: [:new, :create]
  end

  # get "my_puppies", to ""

  resources :users do

    resources :puppies, only: [:index, :new, :create]

    # post ':id/bookings', to:'bookings#create', as: 'userbookings'

  end

  get 'my_puppies', to: 'puppies#mypuppies' , as: 'usermypuppies'

  # post '/puppies' => 'puppies#create'
end
