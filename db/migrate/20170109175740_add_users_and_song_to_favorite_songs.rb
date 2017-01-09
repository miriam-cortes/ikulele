class AddUsersAndSongToFavoriteSongs < ActiveRecord::Migration
  def change
    add_column :favorite_songs, :song_id, :integer
    add_column :favorite_songs, :user_id, :integer
  end
end
