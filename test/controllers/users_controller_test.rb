require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "get new user" do
    get new_user_path
    assert_response :success
  end

end
