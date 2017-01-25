class HomepagesController < ApplicationController
  def search_results
    @search_term = params["search"]
    # raise
    @song_search_results = Song.where("name like ?", "%#{@search_term}%")
    @artist_search_results = Artist.where("name like ?", "%#{@search_term}%")

    return @search_term, @song_search_results, @artist_search_results
  end

  # def random
  # end
  #
  # def chord_bank
  # end

  def favorites
    return @favorites = FavoriteSong.joins(:song).merge(FavoriteSong.where(user_id: current_user.id))
  end
end
