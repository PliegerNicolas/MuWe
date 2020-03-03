Rails.application.routes.draw do
  devise_for :users

  root to: 'events#index'
  get 'jams', to: 'events#jams' # Main jams page similar to index
  get 'prospect', to: 'posts#prospect' # Main prospect page

  get 'profile/edit', to: 'profiles#edit', as: :edit_profile
  patch 'profile/:id', to: 'profiles#update', as: :update_profile
  get 'profile/:id', to: 'profiles#profile', as: :profile # current_user profile page
  resources :events
  resources :profiles, only: [:edit]
end
