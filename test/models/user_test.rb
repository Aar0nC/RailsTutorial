require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Aaron Cotter", email: "aaron@example.com",
                     password: "foobar", password_confirmation: "foobar")
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
    #TODO: use forgery gem to test against random valid email addresses
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

  test "email addresses are unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?, "User #{@user.name} is not unique"
  end

  test "email addresses are unique and case insensitive" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?, "User #{@user.email} is not unique"
  end

  test "email addresses are saved as lower-case" do
    mixed_case_email = "Foo@ExAmPlE.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email,
                 "#{mixed_case_email} is not lowercase"
  end

  test "password can't be blank" do
    @user.password = @user.password_confirmation = "      "
    assert_not @user.valid?, "password is blank"
  end

  test "password must be at least 6 characters" do
    @user.password = @user.password_confirmation = "aaaaa"
    assert_not @user.valid?, "password is less than 6 characters"
  end
end
