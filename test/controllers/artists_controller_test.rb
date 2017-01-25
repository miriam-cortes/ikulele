require 'test_helper'

class ArtistsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should get create" do
  #   get :create, {id: artists(:artistOne)}
  #   assert_response :success
  # end

  # test "should get show_artist_songs" do
  #   param = {id: artists(:artistOne).id}
  #   get :show_artist_songs, param
  #   assert_response :success
  # end

end
