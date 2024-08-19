require "test_helper"

class CopilotsControllerTest < ActionDispatch::IntegrationTest
  test "should get prompt_content" do
    get copilots_prompt_content_url
    assert_response :success
  end
end
