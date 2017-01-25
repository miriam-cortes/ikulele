Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  root to: 'homepages#index'

  resources :artists
  resources :songs

  get 'homepages/index'

  get 'homepages/results'  => 'homepages#search_results', as: 'searchresults'

  # get 'homepages/random'
  # get 'homepages/chord_bank'

  get 'homepages/favorites' => 'homepages#favorites', as: 'favorites'
  post 'sessions/favorites' => 'sessions#handle_favorite', as: 'handle_favorite'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  # match "/404", :to => "errors#not_found", :via => :all
  # match "/500", :to => "errors#internal_server_error", :via => :all
end
