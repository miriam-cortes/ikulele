Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :artists
  resources :songs

  get 'homepages/index'

  get 'homepages/results'  => 'homepages#search_results', as: 'searchresults'

  # get 'homepages/random'
  # get 'homepages/chord_bank'

  get 'homepages/favorites' => 'homepages#favorites', as: 'favorites'
  post 'sessions/favorites' => 'sessions#make_favorite', as: 'make_favorite'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

end
