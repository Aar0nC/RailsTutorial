require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "get new user" do
    get signup_path
    assert_response :success
  end

end
