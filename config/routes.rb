Rails.application.routes.draw do
  get 'messages/create'
  get 'messages/destroy'
  devise_for :users

  root to: 'events#index'

  get 'nearby', to: 'events#nearby' # find events nearby based on geolocation

  get 'profile/edit', to: 'profiles#edit', as: :edit_profile
  patch 'profile/:id', to: 'profiles#update', as: :update_profile
  get 'profile/:id', to: 'profiles#profile', as: :profile # current_user profile page
  
  get 'location', to: 'userlocations#save_location', as: :save_location # Set location in user profile

  get 'dashboard', to: 'dashboards#dashboard', as: :dashboard # Dashboard

  resources :events do
    get 'participants', to: 'participants#show', as: :participants
    post 'participant', to: 'participants#create', as: :add_participant
    delete 'participant', to: 'participants#destroy', as: :remove_participant

    post 'participant/:id/', to: 'participants#accept', as: :accept_user
    delete 'participant/:id/', to: 'participants#decline', as: :decline_user

    resources :messages, only: [:create, :destroy]
  end

  resources :profiles do
    patch 'posts/:id/update', to: 'posts#update', as: :update_post
    resources :posts, only: [:create, :destroy, :edit]
    resources :instrument_users, only: %w(create destroy)
  end

  get 'search', to: 'search#index'

  get '404', to: 'errors#not_found'
  get '422', to: 'errors#unacceptable'
  get '500', to: 'errors#internal_error'
end
