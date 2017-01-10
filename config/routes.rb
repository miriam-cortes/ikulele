Rails.application.routes.draw do
  root to: 'homepages#index'

  resources :artists do
    resources :songs
  end

  # get 'songs/:song_id/show'
  # get 'songs/create'
  # get 'songs/index'

  get 'songs/all_songs' => 'songs#all_songs', as: 'all_songs'
  resources :songs

  get 'homepages/index'

  get 'homepages/results'  => 'homepages#search_results', as: 'searchresults'

  # get 'homepages/:song_id/song'  => 'homepages#song', as: 'song'

  # get 'homepages/:artist_id/artist'  => 'homepages#artist', as: 'artist'

  # get 'homepages/:album_id/album'  => 'homepages#album', as: 'album'

  # get 'homepages/random'
  #
  # get 'homepages/chord_bank'
  #
  # get 'homepages/favorites'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

end
