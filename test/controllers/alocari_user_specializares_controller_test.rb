require 'test_helper'

class AlocariUserSpecializaresControllerTest < ActionController::TestCase
  setup do
    @alocari_user_specializare = alocari_user_specializares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alocari_user_specializares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alocari_user_specializare" do
    assert_difference('AlocariUserSpecializare.count') do
      post :create, alocari_user_specializare: { specializare_id: @alocari_user_specializare.specializare_id, user_id: @alocari_user_specializare.user_id }
    end

    assert_redirected_to alocari_user_specializare_path(assigns(:alocari_user_specializare))
  end

  test "should show alocari_user_specializare" do
    get :show, id: @alocari_user_specializare
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alocari_user_specializare
    assert_response :success
  end

  test "should update alocari_user_specializare" do
    patch :update, id: @alocari_user_specializare, alocari_user_specializare: { specializare_id: @alocari_user_specializare.specializare_id, user_id: @alocari_user_specializare.user_id }
    assert_redirected_to alocari_user_specializare_path(assigns(:alocari_user_specializare))
  end

  test "should destroy alocari_user_specializare" do
    assert_difference('AlocariUserSpecializare.count', -1) do
      delete :destroy, id: @alocari_user_specializare
    end

    assert_redirected_to alocari_user_specializares_path
  end
end
