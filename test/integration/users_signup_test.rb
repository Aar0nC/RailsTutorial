require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "reject invalid signup information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: {
          user: {
              name: "",
              email: "user@invalid",
              password: "foobar",
              password_confirmation: "bar"
          }
      }
    end
    assert_template 'users/new'
  end
end