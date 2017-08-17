require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_tilte = "Ruby on Rails Tutorial Sample App"
  end
  test "get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home | #{@base_tilte}"
  end

  test "get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | #{@base_tilte}"
  end

  test "get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@base_tilte}"
  end

  test "get contact" do
    get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | #{@base_tilte}"
  end
end