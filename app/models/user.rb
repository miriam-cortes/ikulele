class User < ActiveRecord::Base
  has_many :favorite_songs
  has_many :songs, through: :favorite_songs

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name.split(" ").first
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save
    end
  end

end
