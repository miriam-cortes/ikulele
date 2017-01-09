Rails.application.routes.draw do
  root to: 'homepages#index'

  get 'homepages/index'

  get 'homepages/results'  => 'homepages#search_results', as: 'searchresults'

  get 'homepages/song'  => 'homepages#song', as: 'song'

  get 'homepages/artist'  => 'homepages#artist', as: 'artist'

  get 'homepages/album'  => 'homepages#album', as: 'album'

  get 'homepages/random'

  get 'homepages/chord_bank'

  get 'homepages/favorites'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

end
