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

  test "accept valid email addresses" do
    valid_addresses = %w[aaron@example.com USER@foo.COM first.last@foo.jp
alice+bob@bob.cp A_US-ER@foo.bar]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} is valid"
    end
  end

  test "reject invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_addresses.inspect} is invalid"
    end
  end
end
