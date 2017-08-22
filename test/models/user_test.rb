require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Aaron Cotter", email: "aaron@example.com")
  end

  test "valid user" do
    assert @user.valid?, "User isn't valid"
  end

  test "name is present" do
    @user.name = " "
    assert_not @user.valid?, "Name must be present"
  end

  test "email is present" do
    @user.email = " "
    assert_not @user.valid?, "Email must be present"
  end

  test "name is at most 50 characters" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email is at most 255 characters" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
end
