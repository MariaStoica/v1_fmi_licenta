require 'test_helper'

class SpecializaresControllerTest < ActionController::TestCase
  setup do
    @specializare = specializares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:specializares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create specializare" do
    assert_difference('Specializare.count') do
      post :create, specializare: { nume: @specializare.nume }
    end

    assert_redirected_to specializare_path(assigns(:specializare))
  end

  test "should show specializare" do
    get :show, id: @specializare
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @specializare
    assert_response :success
  end

  test "should update specializare" do
    patch :update, id: @specializare, specializare: { nume: @specializare.nume }
    assert_redirected_to specializare_path(assigns(:specializare))
  end

  test "should destroy specializare" do
    assert_difference('Specializare.count', -1) do
      delete :destroy, id: @specializare
    end

    assert_redirected_to specializares_path
  end
end
