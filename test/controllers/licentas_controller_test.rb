require 'test_helper'

class LicentasControllerTest < ActionController::TestCase
  setup do
    @licenta = licentas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:licentas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create licenta" do
    assert_difference('Licenta.count') do
      post :create, licenta: { tema_id: @licenta.tema_id, user_id: @licenta.user_id }
    end

    assert_redirected_to licenta_path(assigns(:licenta))
  end

  test "should show licenta" do
    get :show, id: @licenta
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @licenta
    assert_response :success
  end

  test "should update licenta" do
    patch :update, id: @licenta, licenta: { tema_id: @licenta.tema_id, user_id: @licenta.user_id }
    assert_redirected_to licenta_path(assigns(:licenta))
  end

  test "should destroy licenta" do
    assert_difference('Licenta.count', -1) do
      delete :destroy, id: @licenta
    end

    assert_redirected_to licentas_path
  end
end
