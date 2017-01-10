class SongsController < ApplicationController
  before_action :find_song, only: [:show]
  # before_action :find_artist, except: [:all_songs]

  def all_songs
    @songs = Song.all
  end

  def show
    puts "No song here" if @song == nil
  end

  def new
    @song = Song.new()
    @post_method = :post
  end

  def create
    @song = Song.new
    @song.website = params["song"]["website"]
    @chords, @song_tab_string, @header_array = @song.scrape_song(params["song"]["website"])

    @song.name = @header_array[0]
    @song.artist_id = Artist.find_by(name: @header_array[1]).id
    @song.lyrics_tabs = @song_tab_string
    @song.key = @chords.split(",").first
    @song.sticky_tabs = @chords
    # raise

    if @song.save
      redirect_to artist_song_path(@song.artist_id, @song.id)
    else
      @error = "did not successfully save, please try again."
      @post_path = new_song_path
      @post_method = :post
      render :new
    end
  end

  def index
    @songs = Song.where(artist_id:@artist.id)
  end

  private
  def find_song
    if Song.exists?(params[:id].to_i)
      return @song = Song.find_by(id: params[:id].to_i)
    else
      render :status => 404
    end
  end

  def find_artist
    if Artist.exists?(params[:artist_id].to_i)
      return @artist = Artist.find(params[:artist_id].to_i)
    else
      @artist = Artist.new
    end
  end

  def song_params
    params.require(:song).permit(:website)
  end

end
