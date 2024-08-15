require "test_helper"

class PromptsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prompts_index_url
    assert_response :success
  end

  test "should get show" do
    get prompts_show_url
    assert_response :success
  end

  test "should get new" do
    get prompts_new_url
    assert_response :success
  end

  test "should get create" do
    get prompts_create_url
    assert_response :success
  end

  test "should get edit" do
    get prompts_edit_url
    assert_response :success
  end

  test "should get update" do
    get prompts_update_url
    assert_response :success
  end

  test "should get destroy" do
    get prompts_destroy_url
    assert_response :success
  end
end
