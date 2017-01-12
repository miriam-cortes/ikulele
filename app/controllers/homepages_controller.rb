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
    
  end
end
