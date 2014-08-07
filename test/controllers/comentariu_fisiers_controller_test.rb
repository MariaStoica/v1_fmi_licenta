require 'test_helper'

class ComentariuFisiersControllerTest < ActionController::TestCase
  setup do
    @comentariu_fisier = comentariu_fisiers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comentariu_fisiers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comentariu_fisier" do
    assert_difference('ComentariuFisier.count') do
      post :create, comentariu_fisier: { continut: @comentariu_fisier.continut, fisier_id: @comentariu_fisier.fisier_id, user_id: @comentariu_fisier.user_id }
    end

    assert_redirected_to comentariu_fisier_path(assigns(:comentariu_fisier))
  end

  test "should show comentariu_fisier" do
    get :show, id: @comentariu_fisier
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comentariu_fisier
    assert_response :success
  end

  test "should update comentariu_fisier" do
    patch :update, id: @comentariu_fisier, comentariu_fisier: { continut: @comentariu_fisier.continut, fisier_id: @comentariu_fisier.fisier_id, user_id: @comentariu_fisier.user_id }
    assert_redirected_to comentariu_fisier_path(assigns(:comentariu_fisier))
  end

  test "should destroy comentariu_fisier" do
    assert_difference('ComentariuFisier.count', -1) do
      delete :destroy, id: @comentariu_fisier
    end

    assert_redirected_to comentariu_fisiers_path
  end
end
