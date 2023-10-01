require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get static_pages_top_url
    assert_response :success
  end

  test "should get first_login" do
    get static_pages_first_login_url
    assert_response :success
  end
end
