### app/controllers/songs_controller.rb ###

class SongsController < ApplicationController
  before_action :find_song, :find_artist, only: [:show]

  def show
    render status: 404 if @song == nil
    # puts Time.now
    # @song.sticky_tabs = @song.get_chords_from_api(@song.sticky_tabs)
    # puts Time.now
    if session[:user_id] == nil
      @my_favorite = "♡"
    else
      @my_favorite = is_favorite(@song)
    end
  end

  def new
    @song = Song.new()
    @post_method = :post
  end

  def create
    @song = Song.new
    @song.website = params["song"]["website"]
    if Song.where(website: @song.website).length == 0
      @chords, @song_tab_string, @header_array = @song.scrape_song(params["song"]["website"])

      @song.name = @header_array[0]
      if Artist.find_by(name: @header_array[1]) == nil
        Artist.create(name: @header_array[1])
      end
      @song.artist_id = Artist.find_by(name: @header_array[1]).id
      @song.lyrics_tabs = @song_tab_string
      @song.key = @chords.split(",").first
      @song.sticky_tabs = @song.get_chords_from_api(@chords)


      if @song.save
        redirect_to song_path(@song.id)
      else
        @error = "did not successfully save, please try again."
        @post_path = new_song_path
        @post_method = :post
        render :new
      end
    else
      existing_song = Song.find_by(website: @song.website)
      redirect_to song_path( existing_song.id )
    end
  end

  def index
    @songs = Song.all.order(:name)
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
    if Artist.exists?(@song.artist_id)
      return @artist = Artist.find(@song.artist_id)
    else
      @artist = Artist.new
    end
  end

  def is_favorite(song)
    if FavoriteSong.where(user_id: current_user.id, song_id: @song.id).length == 1
      return "❤️"
    else
      return "♡"
    end
  end


  ##### NOTHING REFERS TO THIS METHOD #####

  def song_params
    params.require(:song).permit(:website)
  end

end
