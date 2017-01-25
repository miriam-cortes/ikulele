require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, {id: songs(:one).id}
    assert_response :success
    assert_equal songs(:one).artist.name, artists(:artistOne).name
    assert_equal songs(:one).lyrics_tabs, "one two three"
    assert_equal songs(:one).key, "key"
    assert_equal songs(:one).sticky_tabs, "tab"
  end

  test "should show a favorite" do
    params = {id: songs(:one).id, session: {user_id: users(:one).id}}
    get :show, params
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should be able to create a new song" do
    assert_difference("Song.count", 1) do
      post_params = {song: {website: "http://www.ukulele-tabs.com/uke-songs/the-beatles/i-wanna-hold-your-hand-uke-tab-4622.html"}}
      post :create, post_params
    end
    assert_response :redirect
  end

  test "should not be able to create a new song if it comes from a website that was already created from" do
    assert_difference("Song.count", 0) do
      post_params = {song: {website: "www.ukulele-tabs.com"}}
      post :create, post_params
    end
    assert_response :redirect
  end

  test "won't create a new song from crap website" do
    assert_difference("Song.count", 0) do
      post_params = {song: {website: " "}}
      post :create, post_params
    end
    assert_response :redirect
    assert_redirected_to new_song_url
  end


end
