require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aaron)
  end

  test "login with invalid credentials" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {
        session: {
            email: "",
            password: ""
        }
    }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid crendentials" do
    get login_path
    post login_path, params: {
        session: {
            email: @user.email,
            password: 'password'
        }
    }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    # Check for updated links
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "logout logged-in user" do
    get login_path
    post login_path, params: {
        session: {
            email: @user.email,
            password: 'password'
        }
    }
    assert is_logged_in?
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
  end
end
