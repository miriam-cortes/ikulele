class HomepagesController < ApplicationController
  def index
  end

  def search_results
    @search_term = params["search"]
    # raise

    return @search_term
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
