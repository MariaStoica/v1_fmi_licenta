require 'test_helper'

class DeadlinesControllerTest < ActionController::TestCase
  setup do
    @deadline = deadlines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deadlines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deadline" do
    assert_difference('Deadline.count') do
      post :create, deadline: { data_end: @deadline.data_end, data_start: @deadline.data_start, descriere: @deadline.descriere, numar: @deadline.numar, nume: @deadline.nume }
    end

    assert_redirected_to deadline_path(assigns(:deadline))
  end

  test "should show deadline" do
    get :show, id: @deadline
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deadline
    assert_response :success
  end

  test "should update deadline" do
    patch :update, id: @deadline, deadline: { data_end: @deadline.data_end, data_start: @deadline.data_start, descriere: @deadline.descriere, numar: @deadline.numar, nume: @deadline.nume }
    assert_redirected_to deadline_path(assigns(:deadline))
  end

  test "should destroy deadline" do
    assert_difference('Deadline.count', -1) do
      delete :destroy, id: @deadline
    end

    assert_redirected_to deadlines_path
  end
end
