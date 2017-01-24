require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, {id: songs(:one).id}
    assert_response :success
    assert_equal songs(:one).artist.name, "First Artist"
    assert_equal songs(:one).lyrics_tabs, "one two three"
    assert_equal songs(:one).key, "key"
    assert_equal songs(:one).sticky_tabs, "tab"
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  #
  # test "should get index" do
  #   get :index
  #   assert_response :success
  # end
  #
  # test "should get all_songs" do
  #   get :all_songs
  #   assert_response :success
  # end

  # test "should be able to create a new song" do
  #   post_params = {song: {name: "Harry Potter Things"}}
  #   post :create, post_params
  #   assert_response :redirect
  # end
end
