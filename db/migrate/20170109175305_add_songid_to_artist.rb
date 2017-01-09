class AddSongidToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :song_id, :integer
  end
end
