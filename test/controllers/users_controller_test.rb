require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get profile_page" do
    get users_profile_page_url
    assert_response :success
  end

end
