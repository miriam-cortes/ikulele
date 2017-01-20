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

  def handle_favorite()
    if params["favorite_status"] == "♡"
      @favorite = FavoriteSong.new
      @favorite.user_id = session[:user_id]
      @favorite.song_id = params["song_id"]
      @favorite.save!
    else
      FavoriteSong.where(user_id: session[:user_id], song_id: params["song_id"])[0].delete
    end
    render json: {ok: true}
    # render song_path(params["song_id"])
  end

end
