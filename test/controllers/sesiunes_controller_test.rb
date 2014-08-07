require 'test_helper'

class SesiunesControllerTest < ActionController::TestCase
  setup do
    @sesiune = sesiunes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sesiunes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sesiune" do
    assert_difference('Sesiune.count') do
      post :create, sesiune: { data_end: @sesiune.data_end, data_start: @sesiune.data_start }
    end

    assert_redirected_to sesiune_path(assigns(:sesiune))
  end

  test "should show sesiune" do
    get :show, id: @sesiune
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sesiune
    assert_response :success
  end

  test "should update sesiune" do
    patch :update, id: @sesiune, sesiune: { data_end: @sesiune.data_end, data_start: @sesiune.data_start }
    assert_redirected_to sesiune_path(assigns(:sesiune))
  end

  test "should destroy sesiune" do
    assert_difference('Sesiune.count', -1) do
      delete :destroy, id: @sesiune
    end

    assert_redirected_to sesiunes_path
  end
end
