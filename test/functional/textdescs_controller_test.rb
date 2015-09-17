require 'test_helper'

class TextdescsControllerTest < ActionController::TestCase
  setup do
    @textdesc = textdescs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:textdescs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create textdesc" do
    assert_difference('Textdesc.count') do
      post :create, textdesc: { name: @textdesc.name, text: @textdesc.text }
    end

    assert_redirected_to textdesc_path(assigns(:textdesc))
  end

  test "should show textdesc" do
    get :show, id: @textdesc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @textdesc
    assert_response :success
  end

  test "should update textdesc" do
    put :update, id: @textdesc, textdesc: { name: @textdesc.name, text: @textdesc.text }
    assert_redirected_to textdesc_path(assigns(:textdesc))
  end

  test "should destroy textdesc" do
    assert_difference('Textdesc.count', -1) do
      delete :destroy, id: @textdesc
    end

    assert_redirected_to textdescs_path
  end
end
