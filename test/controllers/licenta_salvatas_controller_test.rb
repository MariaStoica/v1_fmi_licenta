require 'test_helper'

class LicentaSalvatasControllerTest < ActionController::TestCase
  setup do
    @licenta_salvata = licenta_salvatas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:licenta_salvatas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create licenta_salvata" do
    assert_difference('LicentaSalvata.count') do
      post :create, licenta_salvata: { sesiune_id: @licenta_salvata.sesiune_id, tema_id: @licenta_salvata.tema_id, user_id: @licenta_salvata.user_id }
    end

    assert_redirected_to licenta_salvata_path(assigns(:licenta_salvata))
  end

  test "should show licenta_salvata" do
    get :show, id: @licenta_salvata
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @licenta_salvata
    assert_response :success
  end

  test "should update licenta_salvata" do
    patch :update, id: @licenta_salvata, licenta_salvata: { sesiune_id: @licenta_salvata.sesiune_id, tema_id: @licenta_salvata.tema_id, user_id: @licenta_salvata.user_id }
    assert_redirected_to licenta_salvata_path(assigns(:licenta_salvata))
  end

  test "should destroy licenta_salvata" do
    assert_difference('LicentaSalvata.count', -1) do
      delete :destroy, id: @licenta_salvata
    end

    assert_redirected_to licenta_salvatas_path
  end
end
