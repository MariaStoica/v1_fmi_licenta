require 'test_helper'

class ComentariuLicentasControllerTest < ActionController::TestCase
  setup do
    @comentariu_licenta = comentariu_licentas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comentariu_licentas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comentariu_licenta" do
    assert_difference('ComentariuLicenta.count') do
      post :create, comentariu_licenta: { continut: @comentariu_licenta.continut, licenta_id: @comentariu_licenta.licenta_id, user_id: @comentariu_licenta.user_id }
    end

    assert_redirected_to comentariu_licenta_path(assigns(:comentariu_licenta))
  end

  test "should show comentariu_licenta" do
    get :show, id: @comentariu_licenta
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comentariu_licenta
    assert_response :success
  end

  test "should update comentariu_licenta" do
    patch :update, id: @comentariu_licenta, comentariu_licenta: { continut: @comentariu_licenta.continut, licenta_id: @comentariu_licenta.licenta_id, user_id: @comentariu_licenta.user_id }
    assert_redirected_to comentariu_licenta_path(assigns(:comentariu_licenta))
  end

  test "should destroy comentariu_licenta" do
    assert_difference('ComentariuLicenta.count', -1) do
      delete :destroy, id: @comentariu_licenta
    end

    assert_redirected_to comentariu_licentas_path
  end
end
