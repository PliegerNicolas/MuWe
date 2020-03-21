Rails.application.routes.draw do
  get 'messages/create'
  get 'messages/destroy'
  devise_for :users

  root to: 'events#index'

  get 'jams', to: 'events#jams' # Main jams page similar to index
  get 'prospect', to: 'posts#prospect' # Main prospect page

  get 'nearby', to: 'events#nearby' # find events nearby based on geolocation

  get 'profile/edit', to: 'profiles#edit', as: :edit_profile
  patch 'profile/:id', to: 'profiles#update', as: :update_profile
  get 'profile/:id', to: 'profiles#profile', as: :profile # current_user profile page

  resources :events do
    get 'participants', to: 'participants#show', as: :participants
    post 'participant', to: 'participants#create', as: :add_participant
    delete 'participant', to: 'participants#destroy', as: :remove_participant

    post 'participant/:id/', to: 'participants#accept', as: :accept_user
    delete 'participant/:id/', to: 'participants#decline', as: :decline_user

    resources :messages, only: [:create, :destroy]
  end
  resources :profiles, only: [:edit]

  get 'search', to: 'search#index'

  get '404', to: 'errors#not_found'
  get '422', to: 'errors#unacceptable'
  get '500', to: 'errors#internal_error'
end
