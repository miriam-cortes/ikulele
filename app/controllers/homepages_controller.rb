class HomepagesController < ApplicationController
  def index
  end

  def search_results
    @search_term = params["search"]
    # raise
    @song_search_results = Song.where("name like ?", "%#{@search_term}%")
    @artist_search_results = Artist.where("name like ?", "%#{@search_term}%")

    return @search_term, @song_search_results, @artist_search_results
  end

  def song

  end

  def artist
  end

  def album
  end

  def random
  end

  def chord_bank
  end

  def favorites
    # @current_user = User.find(2)
    puts "THE CURRENT USER IS >>>>>>>>>>>>>>>>" + current_user.id.to_s
    return @favorites = FavoriteSong.where(user_id: current_user.id)
  end
end
