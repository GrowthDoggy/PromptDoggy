require "test_helper"

class EnvironmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get environments_index_url
    assert_response :success
  end

  test "should get show" do
    get environments_show_url
    assert_response :success
  end

  test "should get new" do
    get environments_new_url
    assert_response :success
  end

  test "should get create" do
    get environments_create_url
    assert_response :success
  end

  test "should get edit" do
    get environments_edit_url
    assert_response :success
  end

  test "should get update" do
    get environments_update_url
    assert_response :success
  end

  test "should get destroy" do
    get environments_destroy_url
    assert_response :success
  end
end
