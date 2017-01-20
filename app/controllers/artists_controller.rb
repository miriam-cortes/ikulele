class ArtistsController < ApplicationController
  def index
    @artists = Artist.all.order(:name)
  end

  def show
    find_artist
  end

  def new
    @artist = Artist.new
    @path = artists_path
  end

  def create

    if @artist.save
      redirect_to artist_path(@artist.id)
    else
      @error = "Did not save successfully. Please try again."
      @post_path = artist_path
      @post_method = :post
      render :new
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show_artist_songs
    find_artist
    @songs = Song.find_by(artist_id: @artist.id)
  end

  private

  def find_artist
    if Artist.exists?(params[:id].to_i)
      return @artist = Artist.find_by(id: params[:id].to_i)
    else
      render :status => 404
    end
  end

end
