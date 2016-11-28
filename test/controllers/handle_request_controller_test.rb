require 'test_helper'

class HandleRequestControllerTest < ActionDispatch::IntegrationTest
  test "should get regRequest" do
    get handle_request_regRequest_url
    assert_response :success
  end

end
