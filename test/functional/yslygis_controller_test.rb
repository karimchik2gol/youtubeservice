require 'test_helper'

class YslygisControllerTest < ActionController::TestCase
  setup do
    @yslygi = yslygis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:yslygis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create yslygi" do
    assert_difference('Yslygi.count') do
      post :create, yslygi: { category: @yslygi.category, date: @yslygi.date, description: @yslygi.description, name: @yslygi.name }
    end

    assert_redirected_to yslygi_path(assigns(:yslygi))
  end

  test "should show yslygi" do
    get :show, id: @yslygi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @yslygi
    assert_response :success
  end

  test "should update yslygi" do
    put :update, id: @yslygi, yslygi: { category: @yslygi.category, date: @yslygi.date, description: @yslygi.description, name: @yslygi.name }
    assert_redirected_to yslygi_path(assigns(:yslygi))
  end

  test "should destroy yslygi" do
    assert_difference('Yslygi.count', -1) do
      delete :destroy, id: @yslygi
    end

    assert_redirected_to yslygis_path
  end
end
