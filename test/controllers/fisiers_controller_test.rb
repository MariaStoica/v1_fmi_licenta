require 'test_helper'

class FisiersControllerTest < ActionController::TestCase
  setup do
    @fisier = fisiers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fisiers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fisier" do
    assert_difference('Fisier.count') do
      post :create, fisier: { adaugat: @fisier.adaugat, capitol_id: @fisier.capitol_id, name: @fisier.name, path: @fisier.path, user_id: @fisier.user_id }
    end

    assert_redirected_to fisier_path(assigns(:fisier))
  end

  test "should show fisier" do
    get :show, id: @fisier
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fisier
    assert_response :success
  end

  test "should update fisier" do
    patch :update, id: @fisier, fisier: { adaugat: @fisier.adaugat, capitol_id: @fisier.capitol_id, name: @fisier.name, path: @fisier.path, user_id: @fisier.user_id }
    assert_redirected_to fisier_path(assigns(:fisier))
  end

  test "should destroy fisier" do
    assert_difference('Fisier.count', -1) do
      delete :destroy, id: @fisier
    end

    assert_redirected_to fisiers_path
  end
end
