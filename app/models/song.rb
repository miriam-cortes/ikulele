class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :favorite_songs
  has_many :users, through: :favorite_songs

  def save_new_song()
  end
end
