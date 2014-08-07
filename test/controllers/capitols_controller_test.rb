require 'test_helper'

class CapitolsControllerTest < ActionController::TestCase
  setup do
    @capitol = capitols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:capitols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create capitol" do
    assert_difference('Capitol.count') do
      post :create, capitol: { licenta_id: @capitol.licenta_id, numar: @capitol.numar, nume: @capitol.nume }
    end

    assert_redirected_to capitol_path(assigns(:capitol))
  end

  test "should show capitol" do
    get :show, id: @capitol
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @capitol
    assert_response :success
  end

  test "should update capitol" do
    patch :update, id: @capitol, capitol: { licenta_id: @capitol.licenta_id, numar: @capitol.numar, nume: @capitol.nume }
    assert_redirected_to capitol_path(assigns(:capitol))
  end

  test "should destroy capitol" do
    assert_difference('Capitol.count', -1) do
      delete :destroy, id: @capitol
    end

    assert_redirected_to capitols_path
  end
end
