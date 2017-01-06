Rails.application.routes.draw do
  root to: 'homepages#index'

  get 'homepages/index'

  get 'homepages/results'  => 'homepages#results', as: 'results'

  get 'homepages/song'  => 'homepages#song', as: 'song'

  get 'homepages/artist'  => 'homepages#artist', as: 'artist'

  get 'homepages/album'  => 'homepages#album', as: 'album'

  get 'homepages/random'

  get 'homepages/chord_bank'

  get 'homepages/favorites'

end
