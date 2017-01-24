require 'test_helper'

class HomepagesControllerTest < ActionController::TestCase
  test "should get search_results" do
    get :search_results
    assert_response :success
  end

  # test "should get favorites" do
  #   puts "user_id: >>>>>>>>> " + "#{User.find(users(:one).id).id}"
  #   get :favorites, {user_id: User.find(users(:one).id).id}
  #
  #   assert_response :success
  # end

end
