class AddFavoriteSongs < ActiveRecord::Migration
  def change
    add_column :users, :favorite_songs, :string
  end
end
