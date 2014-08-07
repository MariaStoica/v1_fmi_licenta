require 'test_helper'

class LicentaSalvataControllerTest < ActionController::TestCase
  setup do
    @licenta_salvatum = licenta_salvata(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:licenta_salvata)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create licenta_salvatum" do
    assert_difference('LicentaSalvatum.count') do
      post :create, licenta_salvatum: { sesiune_id: @licenta_salvatum.sesiune_id, tema_id: @licenta_salvatum.tema_id, user_id: @licenta_salvatum.user_id }
    end

    assert_redirected_to licenta_salvatum_path(assigns(:licenta_salvatum))
  end

  test "should show licenta_salvatum" do
    get :show, id: @licenta_salvatum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @licenta_salvatum
    assert_response :success
  end

  test "should update licenta_salvatum" do
    patch :update, id: @licenta_salvatum, licenta_salvatum: { sesiune_id: @licenta_salvatum.sesiune_id, tema_id: @licenta_salvatum.tema_id, user_id: @licenta_salvatum.user_id }
    assert_redirected_to licenta_salvatum_path(assigns(:licenta_salvatum))
  end

  test "should destroy licenta_salvatum" do
    assert_difference('LicentaSalvatum.count', -1) do
      delete :destroy, id: @licenta_salvatum
    end

    assert_redirected_to licenta_salvata_path
  end
end
