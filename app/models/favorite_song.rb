class FavoriteSong < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  def make_favorite(user_id,song_id)
    @favorite = FavoriteSong.new
    @favorite.user_id = session[:user_id]
    @favorite.song_id = (self.find_song).id
    if @favorite.save
      render
    end
  end
end
