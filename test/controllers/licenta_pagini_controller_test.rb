require 'test_helper'

class LicentaPaginiControllerTest < ActionController::TestCase
  test "should get licentaHome" do
    get :licentaHome
    assert_response :success
  end

end
