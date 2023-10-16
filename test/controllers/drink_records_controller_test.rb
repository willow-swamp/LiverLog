require "test_helper"

class DrinkRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get drink_records_new_url
    assert_response :success
  end

  test "should get create" do
    get drink_records_create_url
    assert_response :success
  end

  test "should get show" do
    get drink_records_show_url
    assert_response :success
  end

  test "should get edit" do
    get drink_records_edit_url
    assert_response :success
  end

  test "should get update" do
    get drink_records_update_url
    assert_response :success
  end

  test "should get destroy" do
    get drink_records_destroy_url
    assert_response :success
  end
end
