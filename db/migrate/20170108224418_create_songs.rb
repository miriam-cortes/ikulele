class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :artist
      t.string :lyrics_tabs
      t.string :key
      t.string :sticky_tabs

      t.timestamps null: false
    end
  end
end
