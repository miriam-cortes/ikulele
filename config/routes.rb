Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :artists do
    resources :songs
  end

  resources :songs
  get "/song/:song_id" => 'song#show', as: 'fetch_song'

  get 'homepages/index'

  get 'homepages/results'  => 'homepages#search_results', as: 'searchresults'

  # get 'homepages/random'
  # get 'homepages/chord_bank'

  get 'homepages/:user_id/favorites' => 'homepages#favorites', as: 'favorites'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

end
