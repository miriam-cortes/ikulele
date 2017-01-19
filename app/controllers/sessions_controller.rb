class SessionsController < ApplicationController
  respond_to :js, :json, :html

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def make_favorite()
    binding.pry
    # @favorite = FavoriteSong.new
    # @favorite.user_id = session[:user_id]
    # @favorite.song_id = (self.find_song).id
    # raise
    # if @favorite.save
    #   render_something
    # end
  end

end
