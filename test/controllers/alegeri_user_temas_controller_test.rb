require 'test_helper'

class AlegeriUserTemasControllerTest < ActionController::TestCase
  setup do
    @alegeri_user_tema = alegeri_user_temas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alegeri_user_temas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alegeri_user_tema" do
    assert_difference('AlegeriUserTema.count') do
      post :create, alegeri_user_tema: { sesiune_id: @alegeri_user_tema.sesiune_id, status_profesor: @alegeri_user_tema.status_profesor, status_student: @alegeri_user_tema.status_student, tema_id: @alegeri_user_tema.tema_id, user_id: @alegeri_user_tema.user_id }
    end

    assert_redirected_to alegeri_user_tema_path(assigns(:alegeri_user_tema))
  end

  test "should show alegeri_user_tema" do
    get :show, id: @alegeri_user_tema
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alegeri_user_tema
    assert_response :success
  end

  test "should update alegeri_user_tema" do
    patch :update, id: @alegeri_user_tema, alegeri_user_tema: { sesiune_id: @alegeri_user_tema.sesiune_id, status_profesor: @alegeri_user_tema.status_profesor, status_student: @alegeri_user_tema.status_student, tema_id: @alegeri_user_tema.tema_id, user_id: @alegeri_user_tema.user_id }
    assert_redirected_to alegeri_user_tema_path(assigns(:alegeri_user_tema))
  end

  test "should destroy alegeri_user_tema" do
    assert_difference('AlegeriUserTema.count', -1) do
      delete :destroy, id: @alegeri_user_tema
    end

    assert_redirected_to alegeri_user_temas_path
  end
end
