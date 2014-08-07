require 'test_helper'

class ComentariuCapitolsControllerTest < ActionController::TestCase
  setup do
    @comentariu_capitol = comentariu_capitols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comentariu_capitols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comentariu_capitol" do
    assert_difference('ComentariuCapitol.count') do
      post :create, comentariu_capitol: { capitol_id: @comentariu_capitol.capitol_id, continut: @comentariu_capitol.continut, user_id: @comentariu_capitol.user_id }
    end

    assert_redirected_to comentariu_capitol_path(assigns(:comentariu_capitol))
  end

  test "should show comentariu_capitol" do
    get :show, id: @comentariu_capitol
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comentariu_capitol
    assert_response :success
  end

  test "should update comentariu_capitol" do
    patch :update, id: @comentariu_capitol, comentariu_capitol: { capitol_id: @comentariu_capitol.capitol_id, continut: @comentariu_capitol.continut, user_id: @comentariu_capitol.user_id }
    assert_redirected_to comentariu_capitol_path(assigns(:comentariu_capitol))
  end

  test "should destroy comentariu_capitol" do
    assert_difference('ComentariuCapitol.count', -1) do
      delete :destroy, id: @comentariu_capitol
    end

    assert_redirected_to comentariu_capitols_path
  end
end
