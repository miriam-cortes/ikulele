require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def login_a_user
    auth = OmniAuth.config.mock_auth[:facebook]
    puts "#{auth.uid}"
    get :create,  {uid: '12345'}
  end
  #
  # test "Can Create a user" do
  #   assert_difference('User.count', 1) do
  #     login_a_user
  #     assert_response :redirect
  #     assert_redirected_to root_path
  #   end
  # end

  # test "If a merchant logs in twice it doesn't create a 2nd merchant" do
  #   assert_difference('Merchant.count', 1) do
  #     login_a_merchant
  #   end
  #   assert_no_difference('Merchant.count') do
  #     login_a_merchant
  #     assert_response :redirect
  #     assert_redirected_to merchant_path(Merchant.last.id)
  #   end
  # end

end
