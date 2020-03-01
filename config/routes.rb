Rails.application.routes.draw do
  devise_for :users

  root to: 'events#index'
  get 'jams', to: 'events#jams'
  get 'prospect', to: 'posts#prospect'

  resources :events
end

#  resources :events do
#    collection do
#      get 'jams'
#    end
#  end

#  resources :posts do
#    collection do
#      get 'prospect'
#    end
#  end
