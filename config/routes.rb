Rails.application.routes.draw do
  root to: 'homepages#index'

  get 'homepages/index'

  get 'homepages/results'  => 'homepages#results', as: 'results'

  get 'homepages/song'

  get 'homepages/artist'

  get 'homepages/album'

  get 'homepages/random'

  get 'homepages/chord_bank'

  get 'homepages/favorites'

end
