require 'test_helper'

class AdminPaginiControllerTest < ActionController::TestCase
  test "should get controlPanel" do
    get :controlPanel
    assert_response :success
  end

  test "should get userSpecializari" do
    get :userSpecializari
    assert_response :success
  end

end
