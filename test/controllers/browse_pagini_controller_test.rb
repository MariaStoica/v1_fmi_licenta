require 'test_helper'

class BrowsePaginiControllerTest < ActionController::TestCase
  test "should get browseHome" do
    get :browseHome
    assert_response :success
  end

end
