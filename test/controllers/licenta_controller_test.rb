require 'test_helper'

class LicentaControllerTest < ActionController::TestCase
  setup do
    @licentum = licenta(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:licenta)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create licentum" do
    assert_difference('Licentum.count') do
      post :create, licentum: { tema_id: @licentum.tema_id, user_id: @licentum.user_id }
    end

    assert_redirected_to licentum_path(assigns(:licentum))
  end

  test "should show licentum" do
    get :show, id: @licentum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @licentum
    assert_response :success
  end

  test "should update licentum" do
    patch :update, id: @licentum, licentum: { tema_id: @licentum.tema_id, user_id: @licentum.user_id }
    assert_redirected_to licentum_path(assigns(:licentum))
  end

  test "should destroy licentum" do
    assert_difference('Licentum.count', -1) do
      delete :destroy, id: @licentum
    end

    assert_redirected_to licenta_path
  end
end
