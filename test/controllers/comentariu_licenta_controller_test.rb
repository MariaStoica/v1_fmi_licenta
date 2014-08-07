require 'test_helper'

class ComentariuLicentaControllerTest < ActionController::TestCase
  setup do
    @comentariu_licentum = comentariu_licenta(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comentariu_licenta)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comentariu_licentum" do
    assert_difference('ComentariuLicentum.count') do
      post :create, comentariu_licentum: { continut: @comentariu_licentum.continut, licenta_id: @comentariu_licentum.licenta_id, user_id: @comentariu_licentum.user_id }
    end

    assert_redirected_to comentariu_licentum_path(assigns(:comentariu_licentum))
  end

  test "should show comentariu_licentum" do
    get :show, id: @comentariu_licentum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comentariu_licentum
    assert_response :success
  end

  test "should update comentariu_licentum" do
    patch :update, id: @comentariu_licentum, comentariu_licentum: { continut: @comentariu_licentum.continut, licenta_id: @comentariu_licentum.licenta_id, user_id: @comentariu_licentum.user_id }
    assert_redirected_to comentariu_licentum_path(assigns(:comentariu_licentum))
  end

  test "should destroy comentariu_licentum" do
    assert_difference('ComentariuLicentum.count', -1) do
      delete :destroy, id: @comentariu_licentum
    end

    assert_redirected_to comentariu_licenta_path
  end
end
