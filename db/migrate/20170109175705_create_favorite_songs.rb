class CreateFavoriteSongs < ActiveRecord::Migration
  def change
    create_table :favorite_songs do |t|

      t.timestamps null: false
    end
  end
end
