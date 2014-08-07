require 'test_helper'

class DomeniusControllerTest < ActionController::TestCase
  setup do
    @domeniu = domenius(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:domenius)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create domeniu" do
    assert_difference('Domeniu.count') do
      post :create, domeniu: { descriere: @domeniu.descriere, nume: @domeniu.nume, user_id: @domeniu.user_id }
    end

    assert_redirected_to domeniu_path(assigns(:domeniu))
  end

  test "should show domeniu" do
    get :show, id: @domeniu
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @domeniu
    assert_response :success
  end

  test "should update domeniu" do
    patch :update, id: @domeniu, domeniu: { descriere: @domeniu.descriere, nume: @domeniu.nume, user_id: @domeniu.user_id }
    assert_redirected_to domeniu_path(assigns(:domeniu))
  end

  test "should destroy domeniu" do
    assert_difference('Domeniu.count', -1) do
      delete :destroy, id: @domeniu
    end

    assert_redirected_to domenius_path
  end
end
