require 'test_helper'

class ComentariuTemasControllerTest < ActionController::TestCase
  setup do
    @comentariu_tema = comentariu_temas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comentariu_temas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comentariu_tema" do
    assert_difference('ComentariuTema.count') do
      post :create, comentariu_tema: { continut: @comentariu_tema.continut, tema_id: @comentariu_tema.tema_id, user_id: @comentariu_tema.user_id }
    end

    assert_redirected_to comentariu_tema_path(assigns(:comentariu_tema))
  end

  test "should show comentariu_tema" do
    get :show, id: @comentariu_tema
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comentariu_tema
    assert_response :success
  end

  test "should update comentariu_tema" do
    patch :update, id: @comentariu_tema, comentariu_tema: { continut: @comentariu_tema.continut, tema_id: @comentariu_tema.tema_id, user_id: @comentariu_tema.user_id }
    assert_redirected_to comentariu_tema_path(assigns(:comentariu_tema))
  end

  test "should destroy comentariu_tema" do
    assert_difference('ComentariuTema.count', -1) do
      delete :destroy, id: @comentariu_tema
    end

    assert_redirected_to comentariu_temas_path
  end
end
